class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  before_save :generate_slug

  def total_votes
    total_up_votes - total_down_votes
  end

  def total_up_votes
    self.votes.select{|vote| vote.vote == true}.size
  end

  def total_down_votes
    self.votes.select{|vote| vote.vote == false}.size
  end

  def generate_slug
    base_slug = to_slug(self.title)
    potential_slug = base_slug
    post = Post.find_by slug: base_slug

    count = 2
    while post && post != self
      potential_slug = base_slug + "-" + count.to_s
      post = Post.find_by slug: potential_slug
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