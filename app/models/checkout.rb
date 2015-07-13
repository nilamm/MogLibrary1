class Checkout < ActiveRecord::Base

	belongs_to :resource
	belongs_to :user

	accepts_nested_attributes_for :user

	#attr_accessible :outstanding, :returning
	attr_accessor :returning

	def returning
	end


	def returning=(num)
		self.outstanding -= num.to_i
		#self.resource.num_avail += num.to_i
		#self.resource.save
	end

end
