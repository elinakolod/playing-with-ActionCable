FactoryBot.define do
  factory :personal_message do
    body { FFaker::Lorem.sentence }
  end
end
