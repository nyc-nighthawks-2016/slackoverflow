class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions

  validates :subject, presence: true


  def tagged_today
    #assumes time being tested is a UTC ruby Time object
    @matching_tags = Tag.where(subject: self.subject)
    all_tagged = []
      @matching_tags.each do |tagged|
      today = Time.now.to_a
      test_time = tagged.questions
      test_time.each do |ques|
        test_time = ques.created_at.to_a
        if [today[5],today[4]] == [test_time[5],test_time[4]] && test_time[3] - today[3] <= 1
            all_tagged << tagged
        end
      end
    end
    all_tagged.length
  end

end
