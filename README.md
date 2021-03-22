# アプリケーション名
**『Study Output』**
# アプリケーション概要
このアプリケーションは高校生のための学習アウトプットコミュニケーションサービスです。自分が学びを定着させるためにアウトプットしたり、知識の共有などを目的としています。

# URL
http://52.198.51.125/

# テスト用アカウント
アプリケーション内でゲストユーザーを選択してください。

# 利用方法
| 機能一覧     | 説明  |
|----------- |-----|
| ユーザー機能 | 新規登録、登録内容変更、アバター登録、デフォルトアバター、ログイン、ログアウト、フォロー、ゲストユーザー  |
| 記事投稿機能 | 投稿、編集、削除、閲覧数カウント、リッチなテキストエディタを使用できる|
| タグ機能|タグ付け投稿、タグ検索などをすることができる|
| 記事コメント機能 | コメント投稿（Ajax）、コメント削除機能 |
| 記事いいね機能 | ユーザーは投稿にいいねをできる、マイページでいいねした投稿一覧を取得できる|
| 記事ストック機能 | ユーザーは記事をストックすることができる、ストックした記事はマイページで確認できる|
| ページネーション機能 | 記事は9つずつページネーションする|
| 記事検索機能 | 記事とタグの複合検索ができる|
| 通知機能 | フォロー、いいね、コメントの通知を受け取ることができる、通知が存在する場合、ベルに黄色い丸がつく|
| DM機能| ユーザーはリアルタイムチャットをすることができる|
| DM通知機能 | DMが届いていたら、ヘッダーのメッセージマークに黄色い丸がつく|
| レコメンド機能 | 記事詳細ページの下部にはおすすめの記事が表示される|

# 目指した課題解決
このアプリケーションは高校生は十分なアウトプットをできていないのではないかという問題意識から生まれました。学習において一番大事なのはアウトプットすることです。アウトプットをすれば、人に教えるスキルが上がったり、頭の中が整理され、理解度が向上します。プログラミング界隈にはアウトプットの文化がありますが、高校生の学習においてはそのような文化はありません。僕は大手予備校に通っていましたが、そこは知識をただ単にインプットさせるだけで、最も効果のあるアウトプットの作業を無視していました。このアプリケーションで「高校の学習にアウトプットの文化を作りたい」という思いで、開発しました。



# テーブル設計
## ER図
![study-output-er](https://user-images.githubusercontent.com/78004609/111937975-4ea16300-8b0c-11eb-9499-2ab607b622a3.png)

## usersテーブル

| column             | type   | option   |
|------------------- |------- |--------- |
| nickname           | string | NOT NULL |
| email              | string | NOT NULL |
| encrypted_password | string | NOT NULL |

avatarはActive Storageを使用



### Association

- has_many :articles
- has_many :comments
- has_many :likes
- has_many :stocks
- has_many :messages
- has_many :entries
- has_many :rooms
- has_many :active_dmnotifications, class_name: 'Dmnotification', foreign_key: 'visitor_id', dependent: :destroy 
- has_many :passive_dmnotifications, class_name: 'Dmnotification', foreign_key: 'visited_id', dependent: :destroy
- has_many :relationships, foreign_key: 'user_id', dependent: :destroy
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
- has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


## articlesテーブル

| column           | type       | option                            |
|----------------- |------------|-----------------------------------|
| title            | string     | NOT NULL                          |
| user_id          | references | foreign_key :true, NOT NULL :true |
| impressions_count| integer    | default: 0                        |

content(本文)はAction Textを使用。
imageはActive Storageを使用

### Association
- belongs_to :user
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :notifications, dependent: :destroy
- has_many :stocks, dependent: :destroy
- has_many :stock_users, through: :stocks, source: :user

## commentsテーブル

| column     | type       | option                            |
|------------|------------|---------------------------------- |
| text       | text       | NOT NULL                          |
| user_id    | references | foreign_key :true, NOT NULL :true |
| article_id | references | foreign_key :true, NOT NULL :true |

### Association

- belongs_to :article
- belongs_to :user
- has_many :notifications, dependent: :destroy

## likesテーブル

| column     | type       | option                            |
|----------- |------------|-----------------------------------|
| article_id | references | foreign_key :true, NOT NULL :true |
| user_id    | references | foreign_key :true, NOT NULL :true |

## Association

- belongs_to :article
- belongs_to :user

## stocksテーブル
| column     | type       | option                            |
|----------- |------------|-----------------------------------|
| article_id | references | foreign_key :true, NOT NULL :true |
| user_id    | references | foreign_key :true, NOT NULL :true |

## Association

- belongs_to :article
- belongs_to :user

## relationshipsテーブル

| column    | type       | option                            |
|-----------|------------|-----------------------------------|
| user_id   | references | foreign_key :true, NOT NULL :true |
| follow_id | references | foreign_key :true, NOT NULL :true |

## Association

## notificationsテーブル

| column     | type    | option                                |
|----------- |---------|---------------------------------------|
| visitor_id | integer | NOT NULL :true, add_index             |
| visited_id | integer | NOT NULL :true, add_index             |
| article_id | integer | add_index                             |
| comment_id | integer | add_index                             |
| action     | string  | NOT NULL :true, add_index, default: ''|
|checked     | boolean | default: false, NOT NULL :true        |

## Association
- belongs_to :article, optional: true
- belongs_to :comment, optional: true
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

## roomsテーブル
idのみ

## Association
- has_many :messages,dependent: :destroy
- has_many :users, through: :entries
- has_many :entries, dependent: :destroy
- has_many :dmnotifications, dependent: :destroy

## entriesテーブル
| column  | type       | option            |
|-------- |------------|-------------------|
| room_id | references | foreign_key :true |
| user_id | references | foreign_key :true |

## Association
- belongs_to :user
- belongs_to :room

## messagesテーブル
| column  | type       | option            |
|-------- |------------|-------------------|
| room_id | references | foreign_key :true |
| user_id | references | foreign_key :true |
| message | text       | NOT NULL :true    |

## Association
- belongs_to :user
- belongs_to :room
- has_many :dmnotifications, dependent: :destroy

## dmnotificationテーブル
| column     | type    | option                                |
|----------- |---------|---------------------------------------|
| visitor_id | integer | NOT NULL :true, add_index             |
| visited_id | integer | NOT NULL :true, add_index             |
| message_id | integer | add_index                             |
| room_id    | integer | add_index                             |
| action     | string  | NOT NULL :true, add_index, default: ''|
|checked     | boolean | default: false, NOT NULL :true        |

## Association
- belongs_to :room, optional: true
- belongs_to :message, optional: true
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true


## タグについて
タグに関してはgemの"acts-as-tagable-on"を使用。