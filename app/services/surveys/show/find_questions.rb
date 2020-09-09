require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Show::FindQuestions
  include Dry::Transaction

  def call(input)
    questions = input[:survey].questions.uniq

    if questions.present?
      Success input.merge(questions: questions)
    else
      Failure ({ message: "No se pudo encontrar las preguntas", code: 10101 })
    end
  end
end
