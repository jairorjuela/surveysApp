class Question < ApplicationRecord
  belongs_to :survey
  has_many :options
  has_many :answers

  validates :name, presence: true
end
