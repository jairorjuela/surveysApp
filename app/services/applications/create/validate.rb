require "dry/transaction"
require "dry/transaction/operation"

class Applications::Create::Validate
  include Dry::Transaction

  def call(input)
    validator = Dry::Validation.Schema do
      required(:id).filled(type?: String)
      required(:answers).filled(type?: Array)
      required(:owner).filled(type?: String)
      required(:date_apply).filled(type?: String)
    end

    result = validator.(input)

    if result.success?
      Success input
    else
      Failure result.errors
    end
  end
end
