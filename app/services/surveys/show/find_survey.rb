require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Show::FindSurvey
  include Dry::Transaction

  def call(input)
    survey = Survey.find_by(id: input[:id].to_i)

    if survey.present?
      Success input.merge(survey: survey)
    else
      Failure ({ message: "No se pudo encontrar la encuesta", code: 10101 })
    end
  end
end
