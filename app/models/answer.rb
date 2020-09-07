class Answer < ApplicationRecord
  belongs_to :application
  belongs_to :question
  belongs_to :option
end
