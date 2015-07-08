class CommentsController < ApplicationController
	before_action :require_user, only: [:index, :new, :create, :edit, :update, :destroy]
	before_action :require_admin, only: [:index]
	
	def index
		@region = current_user.region
		@comment_region = Comment.includes(:resource).where(:resources => { :library => @region })
		@comments = @comment_region.all.includes(:user).order("users.last_name ASC")
		#@comments = Comment.all.includes(:user).order("users.last_name ASC")
	end

	def new
		@comment = Comment.new
		@resource = Resource.find(params[:resource_id])
		@user = current_user
		session[:return_to] ||= request.referer
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to session.delete(:return_to)
		else
			render 'new'
		end
	end


	def edit
		@comment = Comment.find(params[:id])
		session[:return_to] ||= request.referer
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			redirect_to session.delete(:return_to)
		else
			render 'edit'
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
	    flash[:success] = "Comment deleted"
	    redirect_to root_path
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :rating, :user_id, :resource_id)
		end
end