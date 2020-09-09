require "dry/transaction"
require "dry/transaction/operation"

class Options::Create::Validate
  include Dry::Transaction

  def call(input)
    validator = Dry::Validation.Schema do
      required(:created_questions).filled(type?: Array)
    end

    result = validator.(input)

    if result.success?
      Success input
    else
      Failure result.errors
    end
  end
end
