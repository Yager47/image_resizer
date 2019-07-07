FactoryBot.define do
  factory :image do
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/image.png") }
    width { Faker::Number.between(50, 500) }
    height { Faker::Number.between(50, 500) }
  end
end
