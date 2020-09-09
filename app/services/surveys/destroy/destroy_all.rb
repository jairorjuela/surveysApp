require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Destroy::DestroyAll
  include Dry::Transaction

  def call(input)
    survey, questions, options = input.values_at(:survey, :questions, :options)
    response = delete_all(survey, questions, options)

    if response
      Success ({ message: "Se eliminó la encuesta"})
    else
      Failure ({ message: "No se pudo eliminar la encuesta", code: 10101 })
    end
  end

  private
  def delete_all(survey, questions, options)
    delete_options = delete_all_options(options)
    delete_questions = delete_options ? delete_all_questions(questions) : false
    delete_survey = delete_questions ? delete_the_survey(survey) : false 
  end

  def delete_all_options(options)
    if options.first.class.eql?(String)
      true
    else
      delete = options.flatten.map(&:destroy)

      delete.nil? ? false : true
    end
  end

  def delete_all_questions(questions)
    delete = questions.map(&:destroy)

    delete.nil? ? false : true
  end

  def delete_the_survey(survey)
    delete = survey.destroy

    delete.nil? ? false : true
  end
end
