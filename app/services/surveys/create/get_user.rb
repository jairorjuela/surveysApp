require "dry/transaction"
require "dry/transaction/operation"

class Surveys::Create::GetUser
  include Dry::Transaction

  def call(input)
    user = User.find_by(email: input[:owner])

    if user.present?
      Success input.merge(user: user)
    else
      Failure ({ message: "Usuario no existe", code: 10104 })
    end
  end
end
