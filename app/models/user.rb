class User < ActiveRecord::Base
	has_secure_password

	def admin?
		self.role == 'admin'
	end

	def name_and_username
		"#{first_name} #{last_name} (#{username})"
	end

	has_many :checkouts
	has_many :resources, through: :checkouts


end
