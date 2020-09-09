require "dry/transaction"
require "dry/transaction/operation"

class Questions::Create::CreateQuestion
  include Dry::Transaction

  def call(input)
    questions = get_questions(input[:questions], input[:survey])

    if questions.present?
      Success input.merge(created_questions: questions)
    else
      Failure ({ message: "No se pudo crear las preguntas", code: 10101 })
    end
  end

  def get_questions(questions, survey)
    questions.each do |question|
      if question.empty?
        question.merge!(error: "No hay preguntas")
      else
        create_ques = create_question(question, survey)

        question.merge!(question: create_ques)
      end
    end
  end

  def create_question(question, survey)
    quest = Question.new(name: question[:name], survey: survey)

    if quest.save
      quest
    else
      quest.errors
    end
  end
end
