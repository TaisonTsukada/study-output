FactoryBot.define do
  factory :article do
    title { '英語学習において単語を覚えることが重要' }
    tag_list { '英語' }
    content { '英語が上達するコツはとりあえずは単語を覚えることである。' }
    association :user
  end
end
