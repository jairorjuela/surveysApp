require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Create::Do
  include Dry::Transaction(container: Container)

  step :validate,           with: 'surveys.create.validate'
  step :get_user,           with: 'surveys.create.get_user'
  step :create_survey,      with: 'surveys.create.create_survey'
  step :validate_question,  with: "questions.create.validate"
  step :create_question,    with: "questions.create.create_question"
  step :validate_option,    with: "questions_options.create.validate"
  step :create_option,      with: "questions_options.create.create_option"
end
