class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_secure_password validations: false
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, length: {minimum: 3}, on: :create
  
end