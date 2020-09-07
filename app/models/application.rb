class Application < ApplicationRecord
  belongs_to :survey
  has_many :answers

  validates :date_apply, presence: true
end
