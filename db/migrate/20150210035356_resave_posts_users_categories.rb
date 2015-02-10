class ResavePostsUsersCategories < ActiveRecord::Migration
  def up
    User.all.each {|user| user.save}
    Post.all.each {|post| post.save}
    Category.all.each {|cat| cat.save}
  end

  def down
  end
end
