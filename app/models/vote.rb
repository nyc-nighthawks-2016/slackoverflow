class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, :votable_id, :votable_type, :vote_value, presence: true
  validates :user_id, uniqueness: true
end
