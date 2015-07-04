class Checkout < ActiveRecord::Base

	belongs_to :resource
	belongs_to :user

	accepts_nested_attributes_for :user

end
