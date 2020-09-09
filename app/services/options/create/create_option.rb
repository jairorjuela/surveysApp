require "dry/transaction"
require "dry/transaction/operation"

class Options::Create::CreateOption
  include Dry::Transaction

  def call(input)
    options = get_options(input[:created_questions])

    if options.present?
      Success input.merge(created_options: options)
    else
      Failure ({ message: "No se pudo crear las opciones", code: 10101 })
    end
  end

  def get_options(options)
    options.each do |option|
      if option.empty?
        option.merge!(error: "No hay opciones")
      else
        create_opt = create_option(option[:options], option[:question])

        option.merge!(options_created: create_opt)
      end
    end
  end

  def create_option(options, question)
    result = options.each_with_object([]) do |option, array|
      option = Option.new(name: option, question: question)

      if option.save
        array << option
      else
        array << option.errors
      end
    end
  end
end
