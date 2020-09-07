FactoryBot.define do
  factory :option do
    name          { "Soy una opción" }
    association   :question,    factory: :question
  end
end
