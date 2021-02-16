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


## articlesテーブル

| column  | type       | option                            |
|-------- |------------|-----------------------------------|
| title   | string     | NOT NULL                          |
| text    | text       | NOT NULL                          |
| user_id | references | foreign_key :true, NOT NULL :true |

### Association

- has_many :tags, through: article_tag
- has_many :comments
- belongs_to :user

## commentsテーブル

| column     | type       | option                            |
|------------|------------|---------------------------------- |
| text       | text       | NOT NULL                          |
| user_id    | references | foreign_key :true, NOT NULL :true |
| article_id | references | foreign_key :true, NOT NULL :true |

### Association

- belongs_to :article
- belongs_to :user

## tagsテーブル

| column | type   | option  |
|--------|------- |-------- |
| text   | string | NOT NULL|

### Association

- has_many :articles, through :article_tag

## article_tagsテーブル

| column     | type      | option                       |
|----------- |-----------|----------------------------- |
| article_id | references| foreign_key :true, NOT :NULL |
| tag_id     | references| foreign_key :true, NOT :NULL |

### Association

- belongs_to :article
- belongs_to :tag
