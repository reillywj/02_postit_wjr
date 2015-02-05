class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :voteable
  validates :body, presence: true

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