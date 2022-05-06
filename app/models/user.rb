class User < ApplicationRecord
  has_many :posts
  has_many :comments
  # has_many :followings, as: :follower, class_name: 'Follow'
  # has_many :followers, as: :following, class_name: 'Follow'
  has_many :followings, class_name: 'Follow', foreign_key: "follower_id"
  has_many :followers, class_name: 'Follow', foreign_key: "following_id"
  has_many :test, through: :followers, source: :user

  scope :search_user_name, ->(keyword) do
    if keyword.present?
      where("users.name LIKE '%#{keyword}%'")
    else
      all
    end
  end

  scope :search_post_title, ->(keyword) do
    if keyword.present?
      joins(:posts).where("posts.title LIKE '%#{keyword}%'")
    else
      all
    end
  end

  scope :good_posts, -> do
    joins(:posts).where("posts.like_count >= 10")
  end

  def total_like_count
    posts.pluck(:like_count).sum
  end
end

# (1..10).each do |i|
#   u = User.create name: "Name - #{i}"
#   like_count = (1..20).to_a.sample
#   post = u.posts.create(title: "post title #{i}", content: "content #{i}", like_count: like_count)
#   if i > 5
#     Comment.create content: "content", user_id: u.id, post_id: post.id
#   end
# end

# Follow.create following_id: 1, following_type: 'User', follower_id: 2, follower_type: 'User'