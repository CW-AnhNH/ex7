class Follow < ApplicationRecord
  belongs_to :following, polymorphic: true
  belongs_to :follower, polymorphic: true
end
