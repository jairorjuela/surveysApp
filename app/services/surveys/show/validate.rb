require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Show::Validate
  include Dry::Transaction

  def call(input)
    validator = Dry::Validation.Schema do
      required(:id).filled(type?: String)
    end

    result = validator.(input)

    if result.success?
      Success input
    else
      Failure result.errors
    end
  end
end
