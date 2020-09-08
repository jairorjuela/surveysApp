class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :applications

  validates :name, presence: true

  def all_questions
    names = self.questions.map(&:name)
    find_questions(names)
  end

  def find_questions(names)
    all_survey = Hash.new

    names.each do |name|
      quest = Question.find_by(name: name)
      all_survey.merge!("#{quest.name}": [quest.options.map(&:name), quest.options.map(&:id)])
    end

    all_survey
  end
end
