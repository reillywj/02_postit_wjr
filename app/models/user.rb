class User < ActiveRecord::Base
  include Sluggable
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, length: {minimum: 3}, on: :create

  sluggable_column :username  


  def self.admin_count
    self.where(user_type: "admin").size
  end

  def self.non_admin_count
    self.total_user_count - self.admin_count
  end

  def self.total_user_count
    self.all.size
  end
end