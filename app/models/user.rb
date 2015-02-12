class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, length: {minimum: 3}, on: :create

  before_save :generate_slug

  def generate_slug
    base_slug = to_slug(self.username)
    potential_slug = base_slug
    user = User.find_by slug: base_slug

    count = 2
    while user && user != self
      potential_slug = base_slug + "-" + count.to_s
      user = User.find_by slug: potential_slug
      count += 1
    end
    self.slug = potential_slug
  end

  def to_slug(str)
    output = str.parameterize.downcase
    output
  end

  def to_param
    self.slug
  end
  
end