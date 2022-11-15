class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :question
  belongs_to :option
  validates :user_key, presence: true
end
