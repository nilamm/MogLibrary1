class User < ActiveRecord::Base
	has_secure_password

	def admin?
		self.role == 'admin'
	end

	def name_and_username
		"#{first_name} #{last_name} (#{username})"
	end

	def first_last
		"#{first_name} #{last_name}"
	end

	has_many :checkouts
	has_many :resources, through: :checkouts
	has_many :comments
	has_many :resources, through: :comments
	has_many :favorites
	has_many :resources, through: :favorites


end
