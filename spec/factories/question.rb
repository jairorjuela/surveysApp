FactoryBot.define do
  factory :question do
    name          { "Soy una pregunta" }
    association   :survey,    factory: :survey
  end
end
