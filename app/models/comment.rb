class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :comment, :user_id, presence: true
  validates :commentable_id, :commentable_type, presence: true
end
