require "dry/transaction"
require "dry/transaction/operation"

class Applications::Create::CreateAnswers
  include Dry::Transaction

  def call(input)
    answers, application, questions, options = input.values_at(:answers, :application, :questions, :options)
    all_answers = create_answers(answers, application, questions, options)

    if all_answers.present?
      Success input.merge(all_answers: all_answers)
    else
      Failure ({ message: "No se pudo responder a la encuesta", code: 10101 })
    end
  end

  def create_answers(answers, application, questions, options)
    ids = get_all_ids(answers, questions, options)

    answers = ids.each_with_object([]) do |id, array|
      answ = Answer.new(application: application, question: id[:question].first, option: id[:answer].first)

      answ.save ? array << answ : array << "No se pudo crear la respuesta"
    end
  end

  def get_all_ids(answers, questions, options)
    questions_ids = get_ids_questions(answers, questions)
    options_ids = get_ids_options(questions_ids, options)
  end

  def get_ids_questions(answers, questions)
    ids = answers.each_with_object([]) do |answer, array|
      ques = questions.select{|question| question.name.eql?(answer[:question]) }
      answer[:question] = ques
      array << answer
    end
  end

  def get_ids_options(answers, options)
    ids = answers.each_with_object([]) do |answer, array|
      opts = options.flatten.select{|option| option.name.eql?(answer[:answer].first) }
      answer[:answer] = opts
      array << answer
    end
  end
end
