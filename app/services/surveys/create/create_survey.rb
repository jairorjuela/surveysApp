require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Create::CreateSurvey
  include Dry::Transaction

  def call(input)
    survey = Survey.new(name: input[:title], user: input[:user])

    if survey.save
      Success input.merge(survey: survey)
    else
      Failure ({ message: "No se pudo crear la encuesta", code: 10101 })
    end
  end
end
