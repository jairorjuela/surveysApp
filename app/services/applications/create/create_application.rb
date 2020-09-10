require "dry/transaction"
require "dry/transaction/operation"

class Applications::Create::CreateApplication
  include Dry::Transaction

  def call(input)
    date_application = get_date(input[:date_apply])
    application = Application.new(date_apply: date_application, survey: input[:survey])

    if application.save
      Success input.merge(application: application)
    else
      Failure ({ message: "No se pudo aplicar a la encuesta", code: 10101 })
    end
  end

  def get_date(date)
    Time.zone.at(date.to_i/1000).to_datetime
  end
end
