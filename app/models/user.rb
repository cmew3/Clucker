require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :name, String
	property :email, String, :format => :email_address, :unique => true, :message => "Email is already registered"
	property :user_name, String, :unique => true, :message => "Username has already been taken" 
	property :password_digest, Text
	has n, :clucks, :through => Resource
	property :password_token, Text
	property :password_token_timestamp, Time

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password, :message => "Ooops...your passwords do not match!"

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def set_reset_token
		update(password_token: (1..60).map{("A".."Z").to_a.sample}.join,
		password_token_timestamp: Time.now)
	end

	def self.authenticate(user_name, password)
		user = first(:user_name => user_name)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end	

	def add_cluck(message,tags=[])
		clucks << Cluck.create(text: message, user: self, tags: tags)
		self.save
	end

	def reset_password(password,password_confirmation)	
		if update(:password => password,
				 :password_confirmation => password_confirmation)
			update(:password_token => nil,
				 :password_token_timestamp => nil)
		else
			false
		end
	end

end