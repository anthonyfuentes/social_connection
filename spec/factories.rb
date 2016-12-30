
FactoryGirl.define do
  factory :photo do
    user nil
  end
  factory :user, aliases: [:author, :friended, :friender] do
    auth_token  'authorized'
    first_name  'First'
    last_name   'Last'
    password    'password'
    sequence(:email) { |n| "#{n}@example.com" }
    trait :with_profile do
      association :profile, factory: :profile
    end
  end

  factory :profile do
    about_me 'This section is about me'
    association :user, factory: :user
  end

  factory :friending do
    sequence(:friender_id) { |n| n }
    sequence(:friended_id) { |n| n  + 1}
    friended
    friender
  end

  factory :post do
    body 'body'
    author
  end

  factory :comment do
    body 'comment'
    author

    association :commentable, factory: :post
  end

  factory :like do
    user

    association :likable, factory: :comment
  end

end
