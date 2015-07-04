class CheckoutsController < ApplicationController
	#restrict new, create, destroy to only admin
	
	def index
		@checkouts = Checkout.all.includes(:user).order("users.last_name ASC")
	end

	def new
		@checkout = Checkout.new
		@resource = Resource.find(params[:resource_id])
	end

	def create
		@checkout = Checkout.new(checkout_params)
		if @checkout.save
			@resource = @checkout.resource
			@new_num_avail = @resource.num_avail - @checkout.num_checked
			@resource.update_attribute(:num_avail, @new_num_avail)
			redirect_to root_path
		else
			render 'edit'
		end
	end


	private
		def checkout_params
			params.require(:checkout).permit(:num_checked, :notes, :user_id, :resource_id)
		end
end
