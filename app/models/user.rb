require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt

	attr_accessor :password, :password_confirmation
	before_save { self.email = email.downcase }
	before_save :encrypt_password
	after_save :clear_password
	before_create :set_api_token


  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}

	protected
		def match_password(login_password="")
	  	encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
		end
  
  private
	  def set_api_token
	    return if api_token.present?
	    self.api_token = generate_auth_token
	  end

	  def generate_auth_token
	    SecureRandom.uuid.gsub(/\-/,'')
	  end
	  def encrypt_password
		if password.present?
	      self.salt = BCrypt::Engine.generate_salt
	      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	    end
	  end
	  
	  def clear_password
	    self.password = nil
	  end

		
	def self.authenticate(username_or_email="", login_password="")
	  if  VALID_EMAIL_REGEX.match(username_or_email)    
	    user = User.find_by_email(username_or_email)
	  else
	    user = User.find_by_username(username_or_email)
	  end
	  if(user && user.encrypted_password == BCrypt::Engine.hash_secret(login_password, user.salt))
	    return user
	  else
	    return false
	  end
	end
end
