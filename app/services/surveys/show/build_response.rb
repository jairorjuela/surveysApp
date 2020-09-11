require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Show::BuildResponse
  include Dry::Transaction

  def call(input)
    survey, questions, options = input.values_at(:survey, :questions, :options)

    response = build_response(survey, questions, options)
  end

  private
  def build_response(survey, questions, options)
    response = {
      title: survey.name,
      questions: build_questions(response, questions, options),
      owner: survey.user.email
    }
  end

  def build_questions(response, questions, options)
    response = Array.new

    questions.each_with_object({}) do |question, hash|
      response << {
        name: question.name,
        options: get_options(options, question.id)
      }
    end

    response
  end

  def get_options(options, question)
    unless(options.flatten.eql?(String))
      response = options.flatten.each_with_object([]) do |option, array|
        option.question_id.eql?(question) ? array << option.name : array
      end
    end
  end
end
