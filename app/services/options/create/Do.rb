require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Options::Create::Do
  include Dry::Transaction(container: Container)

  step :validate,         with: 'questions_options.create.validate'
  step :create_option,    with: 'questions_options.create.create_option'
end
