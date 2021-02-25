# テーブル設計

## usersテーブル

| column             | type   | option   |
|------------------- |------- |--------- |
| nickname           | string | NOT NULL |
| email              | string | NOT NULL |
| encrypted_password | string | NOT NULL |

### Association

- has_many :articles
- has_many :comments
- has_many :likes


## articlesテーブル

| column  | type       | option                            |
|-------- |------------|-----------------------------------|
| title   | string     | NOT NULL                          |
| user_id | references | foreign_key :true, NOT NULL :true |

content(本文)はAction Textを使用。

### Association
- has_many :comments
- belongs_to :user
- has_many :likes

## commentsテーブル

| column     | type       | option                            |
|------------|------------|---------------------------------- |
| text       | text       | NOT NULL                          |
| user_id    | references | foreign_key :true, NOT NULL :true |
| article_id | references | foreign_key :true, NOT NULL :true |

### Association

- belongs_to :article
- belongs_to :user

## likesテーブル

| column     | type       | option                            |
|----------- |------------|-----------------------------------|
| article_id | references | foreign_key :true, NOT NULL :true |
| user_id    | references | foreign_key :true, NOT NULL :true |

## Association

- belongs_to :article
- belongs_to :user

## タグについて
タグに関してはgemの"acts-as-tagable-on"を使用。