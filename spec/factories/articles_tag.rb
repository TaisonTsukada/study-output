FactoryBot.define do
  factory :articles_tag do
    title {"世界史の勉強方法"}
    content {"<div>世界史はインプットとアウトプットの割合が大事です</div>"}
    name {"世界史"}

    association :user

    after(:build) do |article|
      @article = Article.new(title: title, content: content)
    end
  end
end
