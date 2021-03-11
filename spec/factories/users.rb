FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'A123456' }
    password_confirmation { password }

    after(:build) do |user|
      user.avatar.attach(io: File.open('app/assets/images/default_user.png'), filename: 'default_user.png')
    end
  end
end
