FactoryBot.define do
  factory :user do
    access_token { SecureRandom.hex }
  end
end
