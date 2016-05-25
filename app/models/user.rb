require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt

	attr_accessor :password, :password_confirmation
	before_save { self.email = email.downcase }
	before_save :encrypt_password
	after_save :clear_password


  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}

  def encrypt_password
	if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def clear_password
    self.password = nil
  end
end
