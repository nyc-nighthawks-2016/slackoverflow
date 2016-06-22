class User < ActiveRecord::Base
  has_secure_password

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes

  validates :username, :email, { uniqueness: true, presence: true }
  validates :first_name, :last_name, :location, { presence: true }
  validates :password, length: { minimum: 8 }

end
