class User < ActiveRecord::Base
  include Sluggable
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, length: {minimum: 3}, on: :create

  sluggable_column :username  
end