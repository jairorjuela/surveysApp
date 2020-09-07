class Question < ApplicationRecord
  belongs_to :survey
  has_many :questions
  has_many :answers

  validates :name, presence: true
end
