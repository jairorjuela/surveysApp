FactoryBot.define do
  factory :application do
    date_apply    { DateTime.new(2020,9,1) }
    association   :survey,    factory: :survey
  end
end
