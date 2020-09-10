require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Applications::Create::Do
  include Dry::Transaction(container: Container)

  step :validate,            with: 'applications.create.validate'
  step :find_survey,         with: 'surveys.show.find_survey'
  step :find_questions,      with: 'surveys.show.find_questions'
  step :find_options,        with: 'surveys.show.find_options'
  step :create_application,  with: 'applications.create.create_application'
  step :create_answers,      with: 'applications.create.create_answers'
end
