FactoryBot.define do
  factory :user do
    email { "user@test.com" }
    password { "password" }
  end

  factory :post do
    title { "title" }
    summary { "summary" }
    body { "body" }
  end
end
