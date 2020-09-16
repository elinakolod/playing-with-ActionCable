FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "fuckyou#{n}@email.com"
    end
    password { 'DirtyBitch1' }
  end
end
