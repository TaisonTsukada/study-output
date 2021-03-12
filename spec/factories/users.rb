FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { "1a" + Faker::Internet.password(min_length: 6)}
    password_confirmation { password }
    
    after(:build) do |user|
      user.avatar.attach(io: File.open('app/assets/images/default_user.png'), filename: 'default_user.png')
    end
  end
end
