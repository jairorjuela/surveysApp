FactoryBot.define do
  factory :survey do
    name          { "Soy una encuesta" }
    association   :user,    factory: :user
  end
end
