require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Destroy::Do
  include Dry::Transaction(container: Container)

  step :validate,           with: 'surveys.show.validate'
  step :find_survey,        with: 'surveys.show.find_survey'
  step :find_questions,     with: 'surveys.show.find_questions'
  step :find_options,       with: 'surveys.show.find_options'
  step :destroy_all,        with: 'surveys.destroy.destroy_all'
end
