class UsersController < ApplicationController
	before_action :require_user, only: [:index, :new, :create, :edit, :update, :destroy, :show]
	before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]
	#before_filter :authenticate_user! 

	def index
		@users = User.all.order(region: :desc, last_name: :asc)
	end

	def show
		@user = User.find(params[:id])
		@checkouts = @user.checkouts
		@checkouts_out = @checkouts.where("outstanding > 0").includes(:user).order("users.last_name ASC")
		@checkouts_ret = @checkouts.where("outstanding = 0").includes(:user).order("users.last_name ASC")
		
	end

	def user_checkouts
		@region = current_user.region
		#@users = User.where(:region => @region).includes(:checkouts).uniq.order("last_name ASC")
		@users = User.where(:region => @region).joins(:checkouts).uniq.order("last_name ASC")
	end

	def user_favorites
		@region = current_user.region
		@users = User.where(:region => @region).joins(:favorites).uniq.order("last_name ASC")
	end


	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			#session[:user_id] = @user.id
			#@user.update(role: 'user')
			redirect_to '/'
		else
			redirect_to '/signup'
		end
	end

	def edit
		@user = User.find(params[:id])
		session[:return_to] ||= request.referer
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to users_path
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
	    flash[:success] = "User deleted"
	    redirect_to users_path
	end

	private
	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :username, :password, :region, :role)
	  end
end
