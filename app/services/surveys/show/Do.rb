require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Show::Do
  include Dry::Transaction(container: Container)

  step :validate,           with: 'surveys.show.validate'
  step :find_survey,        with: 'surveys.show.find_survey'
  step :find_questions,     with: 'surveys.show.find_questions'
  step :find_options,       with: 'surveys.show.find_options'
  map  :build_response,     with: 'surveys.show.build_response'
end
