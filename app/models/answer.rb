class Answer < ActiveRecord::Base
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  belongs_to :user
  belongs_to :question

  validates :answer, :user_id, :question_id, presence: true

  def vote_count
    # get all votes for this answer
    votes = Vote.where(votable_type: "answer", votable_id: self.id).to_a
    # sum all values of votes
    sum = 0
    votes.each do |vote|
      sum = sum + vote.vote_value
    end
    return sum
  end
end
