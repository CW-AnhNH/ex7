class Follow < ApplicationRecord
  # belongs_to :following, polymorphic: true
  # belongs_to :follower, polymorphic: true
  belongs_to :following
  belongs_to :follower
end
