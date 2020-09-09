require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Questions::Create::Do
  include Dry::Transaction(container: Container)

  step :validate,         with: 'questions.create.validate'
  step :create_question,  with: 'questions.create.create_question'
end
