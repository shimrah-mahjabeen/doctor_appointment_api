class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable, :registerable

  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: true
end
