class AddTimestampsToPostsUsersComments < ActiveRecord::Migration
  def change
    symbols_to_change = [:users, :posts, :comments]
    symbols_to_change.each do |symbol|
      add_column symbol, :created_at, :datetime
      add_column symbol, :updated_at, :datetime
    end
  end
end
