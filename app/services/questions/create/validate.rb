require "dry/transaction"
require "dry/transaction/operation"

class Questions::Create::Validate
  include Dry::Transaction

  def call(input)
    validator = Dry::Validation.Schema do
      required(:survey).filled(type?: Survey)
      required(:questions).filled(type?: Array)
      required(:user).filled(type?: User)
    end

    result = validator.(input)

    if result.success?
      Success input
    else
      Failure result.errors
    end
  end
end
