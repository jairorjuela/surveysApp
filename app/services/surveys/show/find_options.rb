require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Show::FindOptions
  include Dry::Transaction

  def call(input)
    options = get_options(input[:questions])

    if options.present?
      Success input.merge(options: options)
    else
      Failure ({ message: "No se pudo encontrar las opciones", code: 10101 })
    end
  end

  def get_options(questions)
    options = questions.each_with_object([]) do |question, array|
      if question.options.present?
        array << question.options.uniq
      else
        array << "no hay opciones para #{question.name}"
      end
    end
  end
end
