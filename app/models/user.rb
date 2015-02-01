class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_secure_password validations: false
  validate :username, uniqueness: true, presence: true
  validate :password_digest, presence: true, length: {minimum: 3}, on: :create
  
end