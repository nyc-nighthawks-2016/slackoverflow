users = []

20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  users << User.create!({
                         first_name: first_name,
                         last_name: last_name,
                         username: Faker::Internet.user_name("#{first_name} #{last_name[0..2]}", %w(. _ -)),
                         email: Faker::Internet.free_email("#{first_name}.#{last_name}"),
                         password: Faker::Internet.password(8, 15),
                         location: Faker::Address.city})
end

questions = []
20.times do
  questions << Question.create!({
                                title: Faker::Company.catch_phrase,
                                question: Faker::Hipster.paragraphs,
                                user_id: rand(1..20),
                                vote_count: rand(500),
                                created_at: Faker::Date.between(10.days.ago, Date.today)})
end


40.times do
  Answer.create!({
                  answer: Faker::Company.catch_phrase,
                  user_id: rand(1..20),
                  question_id: rand(1..20),
                  vote_count: rand(25)})
end

40.times do
  Comment.create!({
                   comment: Faker::Hipster.paragraphs,
                   user_id: rand(1..20),
                   commentable_id: rand(1..20),
                   commentable_type: "question"})
end

40.times do
  Comment.create!({
                   comment: Faker::Hipster.paragraphs,
                   user_id: rand(1..20),
                   commentable_id: rand(1..40),
                   commentable_type: "answer"})
end

# value = [-1, 1]
# 40.times do
#   Vote.create!({
#                    vote_value: value.sample,
#                    user_id: rand(1..20),
#                    votable_id: rand(1..20),
#                    votable_type: "question"})
# end

# 40.times do
#   Vote.create!({
#                    vote_value: value.sample,
#                    user_id: rand(1..20),
#                    votable_id: rand(1..40),
#                    votable_type: "answer"})
# end
