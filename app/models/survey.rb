class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :applications

  validates :name, presence: true
end
