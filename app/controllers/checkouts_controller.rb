class CheckoutsController < ApplicationController
	#restrict new, create, destroy to only admin
	before_action :require_user, only: [:index, :new, :create, :return, :return_update, :edit, :update]
	before_action :require_admin, only: [:index, :new, :create, :return, :return_udpate, :edit, :update, :destroy]
	
	def index
		@region = current_user.region
		@checkouts = Checkout.includes(:resource).where(:resources => { :library => @region })
		@checkouts_out = @checkouts.where("outstanding > 0").includes(:user).order("users.last_name ASC")
		@checkouts_ret = @checkouts.where("outstanding = 0").includes(:user).order("users.last_name ASC")
	end

	def new
		@checkout = Checkout.new
		@resource = Resource.find(params[:resource_id])
		session[:return_to] ||= request.referer
	end

	def create
		@checkout = Checkout.new(checkout_params)
		if @checkout.save
			@checkout.update(outstanding: @checkout.num_checked)
			#@resource = @checkout.resource
			#@resource.num_avail -= @checkout.num_checked
			#@resource.save
			#redirect_to root_path
			redirect_to session.delete(:return_to)
		else
			render 'new'
		end
	end

	def return
		@checkout = Checkout.find(params[:id])
		session[:return_to] ||= request.referer
	end

	def return_update
		@checkout = Checkout.find(params[:id])
		if @checkout.update_attributes(return_params)
			redirect_to session.delete(:return_to)
		else
			render 'return'
		end
	end

	def edit
		@checkout = Checkout.find(params[:id])
		session[:return_to] ||= request.referer
	end

	def update
		@checkout = Checkout.find(params[:id])
		if @checkout.update_attributes(checkout_params)
			redirect_to session.delete(:return_to)
		else
			render 'edit'
		end
	end

	def destroy
		Checkout.find(params[:id]).destroy
	    flash[:success] = "Checkout deleted"
	    redirect_to root_path
	end

	private
		def checkout_params
			params.require(:checkout).permit(:num_checked, :notes, :user_id, :resource_id, :outstanding)
		end

		def return_params
			params.require(:checkout).permit(:returning, :notes)
		end
end
