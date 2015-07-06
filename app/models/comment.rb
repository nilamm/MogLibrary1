class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :resource

	def rating_stars
		stars = ""
		if rating.present?
			rating.times do
				stars += '<span class="glyphicon glyphicon-star rating-star"></span>'
			end
		end
		stars
	end

end
