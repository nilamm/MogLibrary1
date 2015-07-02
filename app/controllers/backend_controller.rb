class BackendController < ApplicationController
	before_action :require_user, only: [:index]
	before_action :require_admin, only: [:index]
	def index
	end
end
