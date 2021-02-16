FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'A123456'}
    password_confirmation {password}
  end
end