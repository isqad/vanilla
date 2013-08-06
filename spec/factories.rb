FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "andrew#{n}@yandex.ru" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:username) { |n| "andrew#{n}" }

    confirmed_at Time.now

    association :profile, :factory => :profile
  end

  factory :profile do
    sequence(:first_name) { |n| "Andrew#{n}" }
    sequence(:last_name) { |n| "Hunter#{n}" }
  end
end