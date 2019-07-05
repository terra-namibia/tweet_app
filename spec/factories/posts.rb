FactoryBot.define do
  factory :post do
    content {"MyString"}
    user_id {1}

    trait :long_content do
      content {"123456789012345678901234567890"}
    end

  end
end
