class CatalogController < ApplicationController
	before_action :require_user, only: [:search, :index, :edit, :update, :new, :create, :show, :show_checkouts]
	before_action :require_admin, only: [:index, :new, :create]

	def welcome
		@resource_count = Resource.all.count
	end

	def index
		@resources = Resource.all.order(:title)
		respond_to do |format|
			format.html
			format.xls
		end
	end

	def show
		@resource = Resource.find(params[:id])
	end
	
	def search
		@pagelimit = 20
		if params[:search]
			#@resources = Resource.search(params[:search]).order(:title)
			#@resources = Resource.search(params[:search]).where(:id => current_user.id)
		else
			@resources = nil
		end
		@resources_total = @resources.count
		@resources_showing = @resources.limit(@pagelimit).count
		@resources = @resources.paginate(:page => params[:page], :per_page => @pagelimit)
	end

	def edit
		@resource = Resource.find(params[:id])
		session[:return_to] ||= request.referer
	end

	def update
		@resource = Resource.find(params[:id])
		if @resource.update_attributes(resource_params)
			redirect_to session.delete(:return_to)
		else
			render 'edit'
		end
	end

	def new
		@resource = Resource.new
		session[:return_to] ||= request.referer
	end

	def create
		@resource = Resource.new(resource_params)
		if @resource.save
			@resource.update(num_avail: @resource.num_tot)
			#redirect_to root_path
			redirect_to session.delete(:return_to)
		else
			render 'new'
		end
	end

	def show_checkouts
		@resource = Resource.find(params[:id])
		@checkouts = @resource.checkouts
		@checkouts_out = @checkouts.where("outstanding > 0").includes(:user).order("users.last_name ASC")
		@checkouts_ret = @checkouts.where("outstanding = 0").includes(:user).order("users.last_name ASC")
	end

	private
		def resource_params
			params.require(:resource).permit(:title, :composer, :arranger, :libretto, :voice, :accomp, :genre, :language, :region, :theme, :curric, :additional, :res_type, :link, :pic, :num_avail, :num_tot)
		end

	
end
