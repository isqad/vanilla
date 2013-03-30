FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "andrew#{n}@yandex.ru" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:nickname) { |n| "andrew#{n}" }
    confirmed_at Time.now
  end
end