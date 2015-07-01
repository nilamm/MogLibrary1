class Resource < ActiveRecord::Base
	def self.search(query)
		where("title like ? OR composer like ? OR arranger like ? OR libretto like ? OR voice like ? OR accomp like ? OR genre like ? OR language like ? OR region like ? OR theme like ? OR curric like ? OR additional like ? OR res_type like ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
	end

end
