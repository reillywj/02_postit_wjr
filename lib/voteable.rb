# Using Concerns
=begin
module Voteable
  extend ActiveSupport::Concern
  included do 
    has_many :votes, as: :voteable
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.select{|vote| vote.vote == true}.size
  end

  def down_votes
    self.votes.select{|vote| vote.vote == false}.size
  end
end
=end

=begin
module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      up_votes - down_votes
    end

    def up_votes
      self.votes.select{|vote| vote.vote == true}.size
    end

    def down_votes
      self.votes.select{|vote| vote.vote == false}.size
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end
end
=end