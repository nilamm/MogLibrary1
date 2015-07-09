class FavoritesController < ApplicationController
	before_action :require_user, only: [:index, :create, :destroy]

	def index
		@user = current_user
		@favorites = @user.favorites
	end

	def by_user
		@user = User.find(params[:id])
		@favorites = @user.favorites
	end

	def create
		@favorite = Favorite.new(favorite_params)
		if @favorite.save
			redirect_to favorites_path
		else
			redirect_to root_path
		end
	end

	def destroy_by_params
		@favorite = Favorite.find_by(user_id: params[:user_id], resource_id: params[:resource_id])
		if @favorite
			@favorite.destroy
		end
	    flash[:success] = "Removed from favorites"
	    redirect_to favorites_path
	end

private
	def favorite_params
		params.permit(:user_id, :resource_id)
	end

end
