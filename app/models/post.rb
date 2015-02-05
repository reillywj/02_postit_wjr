class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  def total_votes
    total_up_votes - total_down_votes
  end

  def total_up_votes
    self.votes.select{|vote| vote.vote == true}.size
  end

  def total_down_votes
    self.votes.select{|vote| vote.vote == false}.size
  end
end