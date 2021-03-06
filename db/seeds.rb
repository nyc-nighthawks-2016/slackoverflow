users = []

# What has been Seeded:
# Users (20)
# Questions (20)
# Answers (40)
# Comments (80) (40 on questions, 40 on answers)
# Tags (40)
# Tag associated with question (10)

User.delete_all
Question.delete_all
Answer.delete_all
Comment.delete_all
Tag.delete_all
Vote.delete_all

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
                                created_at: Faker::Date.between(10.days.ago, Date.today)})
end


40.times do
  Answer.create!({
                  answer: Faker::Hipster.paragraphs,
                  user_id: rand(1..20),
                  question_id: rand(1..20)
                  })
end

40.times do
  Comment.create!({
                   comment: Faker::Hipster.paragraphs,
                   user_id: rand(1..20),
                   commentable_id: rand(1..20),
                   commentable_type: "Question"})
end

40.times do
  Comment.create!({
                   comment: Faker::Hipster.paragraphs,
                   user_id: rand(1..20),
                   commentable_id: rand(1..40),
                   commentable_type: "Answer"})
end

question = Question.find(1)

Vote.create!(user_id: question.user_id, votable_id: 1, votable_type: "Question", vote_value: 1)

40.times do
  Tag.create!({subject: Faker::Superhero.name,
              summary: Faker::Lorem.paragraph(2)})
end


60.times do
    Question.find(rand(1..20)).tags << Tag.find(rand(1..40))
end
