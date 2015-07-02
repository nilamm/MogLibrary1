class UsersController < ApplicationController
	before_action :require_user, only: [:index, :new, :create, :edit, :update, :destroy, :show]
	before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy, :show]

	def index
		@users = User.all.order(:last_name)
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

	def show
	end

	private
	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :username, :password, :region, :role)
	  end
end
