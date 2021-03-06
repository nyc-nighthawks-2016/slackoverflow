class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :answers
  has_and_belongs_to_many :tags

  validates :title, length: {maximum: 128}
  validates :title, :user_id, presence: true

  def vote_count
    # get all votes for this answer
    votes = Vote.where(votable_type: "Question", votable_id: self.id).to_a
    # sum all values of votes
    # votes.reduce{ |sum, vote| sum + vote.vote_value }
    sum = 0
    votes.each do |vote|
      sum = sum + vote.vote_value
    end
    return sum
  end

  def self.popularity
    the_class = self.all.to_a
    the_class.sort_by { |tag| tag.vote_count }.reverse
  end

end
