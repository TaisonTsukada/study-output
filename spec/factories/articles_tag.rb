FactoryBot.define do
  factory :articles_tag do
    title {"世界史の勉強方法"}
    content {"世界史はインプットとアウトプットの割合が大事です"}
    name {"世界史"}

    association :user
  end
end
