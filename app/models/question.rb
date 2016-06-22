class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_and_belongs_to_many :tags
end
