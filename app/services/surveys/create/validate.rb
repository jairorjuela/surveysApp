require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Create::Validate
  include Dry::Transaction

  def call(input)
    validator = Dry::Validation.Schema do
      required(:title).filled(type?: String)
      required(:questions).filled(type?: Array)
      required(:owner).filled(type?: String)
    end

    result = validator.(input)

    if result.success?
      Success input
    else
      Failure result.errors
    end
  end
end
