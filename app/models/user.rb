class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, length: {minimum: 3}, on: :create

  before_save :generate_slug

  def generate_slug
    self.slug = self.username.gsub(/[\s\W]/,"-").gsub(/-+/,"-").gsub(/-$/,"")
  end

  def to_param
    self.slug
  end
  
end