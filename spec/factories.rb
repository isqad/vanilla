FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "andrew#{n}@yandex.ru" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:username) { |n| "andrew#{n}" }
    sequence(:first_name) { |n| "Andrew#{n}" }
    sequence(:last_name) { |n| "Hunter#{n}" }

    confirmed_at Time.now
  end
end