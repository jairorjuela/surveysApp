class Option < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates :name, presence: true
end
