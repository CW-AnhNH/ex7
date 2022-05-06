class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  scope :has_comments, -> do
    joins(:comments).where.not(comments: { id: nil })
  end

  scope :good_posts, -> do
    where("like_count >= 10")
  end

  # def user_has_commented
  #   user_ids = comments.pluck(:user_id)
  #   User.where(id: user_ids)
  #   --> OR
  #   User.joins(:comments).where(comments: { post_id: id })
  # end
end

Post.where('id <= 5').includes(:user).each do |post|
  puts "Post title: #{post.title}, User name: #{post.user.name}"
end

users_data = User.pluck(:id, :name).to_h
Post.where('id <= 5').each do |post|
  puts "Post title: #{post.title}, User name: #{users_data[post.user_id]}"
end

