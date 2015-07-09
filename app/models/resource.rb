class Resource < ActiveRecord::Base
	def self.search(query)
		where("title like ? OR composer like ? OR arranger like ? OR libretto like ? OR voice like ? OR accomp like ? OR genre like ? OR language like ? OR region like ? OR theme like ? OR curric like ? OR additional like ? OR res_type like ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
	end

	include PgSearch
	pg_search_scope :search_resources, :against => [:title, :composer, :arranger, :libretto, :voice, :accomp, :genre, :language, :region, :theme, :curric, :additional, :res_type]

	has_many :checkouts
	has_many :users, through: :checkouts
	has_many :comments
	has_many :users, through: :comments
	has_many :favorites
	has_many :users, through: :favorites

	def avg_rating
		if comments.sum(:rating) > 0
			@avg = comments.average(:rating)
			rating = @avg.round
			stars = ""
			rating.times do
				stars += '<span class="glyphicon glyphicon-star rating-star"></span>'
			end
			stars
		end
	end

	def checkouts_count
		@checkouts_out = checkouts.where("outstanding > 0")
		@checkouts_out.count
	end

	def checkouts_past
		@checkouts_ret = checkouts.where("outstanding = 0")
		@checkouts_ret.count
	end

end
