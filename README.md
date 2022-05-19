# アプリケーション名
**『Study Output』**
# アプリケーション概要
このアプリケーションは高校生のための学習アウトプットコミュニケーションサービスです。自分が学びを定着させるためにアウトプットしたり、知識の共有などを目的としています。

# URL
https://study-output.net/

# テスト用アカウント
アプリケーション内でゲストユーザーを選択してください。

# 利用方法
まずユーザー認証をする必要があります。ユーザー認証が全ての機能を使用することができます。
## 記事投稿
ヘッダーの右上の投稿ボタンをクリックすると記事の投稿をすることができます。記事の投稿に必須なのはタイトル、タグ、本文です。それを全て入力すると記事を投稿することができます。
## 記事一覧
投稿した記事はindexページに表示されます。サイドバーには人気のあるタグが15個存在し、それをクリックするとタグ検索ができます。ページの上部にあるナビゲーションバーで記事の並び替えをすることができます。「新着記事順」と「いいね数の多い記事順」、「閲覧数の多い記事順」の3つの条件で並び替えが可能です。一番右にある「全タグ一覧」はアプリケーションで使用されているタグが全て表示されます。
## 記事検索機能
ヘッダーにある検索バーでタグと記事タイトルの複合検索ができます。
## 記事詳細機能
記事詳細ページでは記事の閲覧、いいね、ストックコメントなどをすることができます。記事投稿者本人は記事の削除、編集をすることができます。
最下部にはタグを部分検索したレコメンドシステムでおすすめの記事が表示されます。

## 通知機能
自分が投稿した記事のコメント、いいねや自分に対するフォローには通知がきます。通知が存在する場合はヘッダーのベルマークに黄色い丸が表示されます。クリックするとモーダルで通知一覧が表示されます。

## DM機能
ユーザー同士はDMでコミュニケーションを取ることができます。メッセージはリアルタイムで反映されます。

# 目指した課題解決
このアプリケーションは高校生は十分なアウトプットをできていないのではないかという問題意識から生まれました。学習において一番大事なのはアウトプットすることです。アウトプットをすれば、人に教えるスキルが上がったり、頭の中が整理され、理解度が向上します。プログラミング界隈にはアウトプットの文化がありますが、高校生の学習においてはそのような文化はありません。僕は大手予備校に通っていましたが、そこは知識をただ単にインプットさせるだけで、最も効果のあるアウトプットの作業を無視していました。このアプリケーションで高校の学習にアウトプットの文化を作りたいです。




# 洗い出した要件

|優先順位 3~1|機能        |目的         |詳細        |ストーリー |見積もり|
|--------------------------|----------- |------------|-----------|----------|------|
|3|ユーザー管理機能|アプリケーションでユーザーを作成できるように実装する|メールアドレス、ニックネーム、パスワード、アバターを設定できるようにする|ユーザーを一人ひとり識別するため、ユーザー新規登録とログインページを実装する。ユーザーのオリジナリティを出すために、アバターとニックネームを実装した|1日|
|3|記事投稿機能|ユーザーに勉強した内容のアウトプットをしてもらうため|ブログのような形式で記事を投稿できるようにする|手軽に文章が編集できるようなフォームを用いて、高校生がストレスなく記事を投稿できる環境を整える。|3日|
|3|記事一覧機能|トップページ記事を一覧表示してどの記事を読むか、ユーザーに選んでもらうため|「note」のような形式のトップページにして、記事を一覧表示させる|ユーザーがスクロールするだけで様々記事を選び取れるようにする|1日|
|3|記事詳細閲覧機能|トップページで記事をクリックしたら、記事の詳細が見えるようにする|こちらも「note」のような記事詳細ページにする。コンテンツを中央に集中させる|ユーザーがタイトル、タグ、投稿したユーザーなどの情報を直感的にわかるようにする|1日|
|3|記事編集機能|記事を投稿したユーザーは投稿した記事を編集できるようにする|記事内容が間違っていたりした場合のために、投稿したユーザーは記事を編集できるようにする|記事詳細画面に投稿したユーザーだけに編集のページのリンクが存在する|1日|
|3|記事削除機能|記事を投稿したユーザーは投稿した記事を削除することができるようにする|投稿したユーザーは自由に記事を削除することができるようにする|こちらも記事詳細画面に投稿したユーザーだけに削除のリンクが存在する|1日|
|3|ユーザー詳細ページ|ユーザー詳細ページを作成し、そのユーザーが投稿した記事一覧を表示する|ユーザーが投稿した記事を一覧表示するようにする。記事の詳細ページのリンクなどから飛べる。マイページの場合は、ユーザー情報の編集などができるようにする|ユーザ詳細ページで記事を一覧表示し、投稿に紐づいているユーザーのリンクから、飛ぶことができる。マイページの場合、ヘッダーにURLがある|1日|
|3|ユーザー編集機能|本人だけがユーザー編集をすることができる。|そのユーザー本人のみユーザ編集をすることができる|ユーザー本人だった場合、ユーザー詳細ページにユーザー編集のリンクがあるようにする。その際、パスワードの入力なしで編集ができるようにする|1日|
|2|タグ付け投稿機能|タグ付けをして記事を投稿できるようにする|投稿の際にタグをつけて記事を投稿できるようにする。タグ検索、タグカウントも実装する|投稿フォームでタグ付けをすることができる。そしてトップページに人気のタグ一覧、そしてタグ検索ができるようにする|2日|
|2|記事検索機能|記事を検索できるようにする|記事を自由に検索できるようにする。その際、タグ名と記事のタイトルを含めた複合検索にする|常にヘッダーに記事検索フォームを用意して、常に検索できるようにする。|1日|
|2|コメント機能|ユーザー同士の自由なコミュニケーションを促進させるため、記事にコメントができるようにする。|一つの記事につき一つコメント欄とコメントフォームを実装する。その際、ログインしていないユーザーには表示しないようにする。|記事の下部にコメント欄があり、コメントフォームがあるようにする。|1日|
|2|記事並び替え機能|記事を要素によって並び替えられるようにする|新着順、閲覧数、いいね数、タイムラインの四つで並び替えられるようにする|トップページで記事を並び替えられるようにする。その際どの一覧を表示しているのか視覚的にわかるようにする|1日|
|2|いいね機能|投稿した記事にいいねができるようにする|非同期でいいね機能を実装する。そしてユーザーマイページでいいねした記事一覧を表示させる。| いい記事を見つけた場合は、いいねボタンを押すことができる。いいね数は可視化され、いいねランキングなども作られる|1日|
|2|記事ストック機能|投稿した記事をストックすることができるようにする。|非同期でストック機能を実装する。そしてユーザーマイページでストックした記事を一覧表示させる|あとでもう一度見返したい時などに、記事をストックできる。|1日|
|2|フォロー機能|ユーザ同士で盛んにコミュニケーションを図るため。|ユーザ詳細ページにいくと、フォローボタンが存在し、フォローすることができる|ユーザー詳細ページでフォローをすることができる。フォロー数、フォロワー数も非同期で表示されており、クリックするとそのユーザー一覧をみることができる|1日|
|2|閲覧数取得機能| 投稿したユーザーの投稿のモチベーションを上げるため|ipアドレスを基準に閲覧数を取得することができる。それは詳細ページに表示され、トップページの閲覧数の多い順にも反映される|記事詳細ページに閲覧数が表示されている。その閲覧数でトップページでランキングが作成されている|１日|
|2|レコメンド機能|ユーザーに様々な記事を見てもらうため|記事詳細ページに今見ている記事に似ている投稿の一覧が表示される|記事詳細ページの最下部にはあなたへのおすすめ記事が存在する|1日|
|2|通知機能|他のユーザーの現在のユーザーに対するアクションに気づいてもらうため|ヘッダーのベルマークを押すとフォロー、コメント、いいねの通知一覧が表示される|新しい通知があるとヘッダーのベルマークが黄色く光る|1日|
|2|履歴機能|履歴機能|ユーザーマイページにユーザーの履歴が表示される|ユーザーマイページの履歴のリンクを押すとユーザーの履歴が一覧表示される|1日|
|1|DM機能|ユーザーの密なコミュニケーションを実現するため、DM機能を実装する|ユーザー同士でリアルタイムでメッセージを送り合うことができる。|ユーザー詳細ページ、またはヘッダーにのあるメッセージアイコンを押すとDM画面に遷移する|1日|
|1|DM通知機能|未読のDMがあることをユーザーに気づかせるため|メッセージが届いたことがわかるようにした。|新着メッセージがあると、メッセージアイコンに黄色い丸がつくようにした|1日｜
|1|ページネーション機能|アプリケーションの動作が重くならないようにページネーション機能を実装した|トップページの記事が9つを超えたら、ページネーションが作動するようにした|トップページの最下部に、ページネーションボタンが存在する|1日|

# 実装した機能について
## 記事投稿機能

https://user-images.githubusercontent.com/78004609/112106987-c0071180-8bf1-11eb-84f7-f5b18a82fc69.mp4

このようにAction textを用いて記事を投稿することができます。サムネイル、youtubeの動画なども可能です。

## 記事一覧表示機能

https://user-images.githubusercontent.com/78004609/112107698-a31f0e00-8bf2-11eb-9ed2-863f580f5d9c.mp4

このように記事は一覧表示されます。新着記事、タイムライン、閲覧数が多い記事、いいね数の多い記事などで並び替えができます。

## タグ検索機能


https://user-images.githubusercontent.com/78004609/112107979-fee99700-8bf2-11eb-9592-a1971f42ba0f.mp4


このようにタグをクリックするとタグ検索ができます。

## 記事検索機能

https://user-images.githubusercontent.com/78004609/112108202-38ba9d80-8bf3-11eb-9669-fcf081f39977.mp4

ヘッダーにある検索フォームをクリックすると、タグと記事のタイトルを元に複合検索ができます。


## 記事詳細機能

https://user-images.githubusercontent.com/78004609/112107349-2db33d80-8bf2-11eb-9e21-5feb0589a7db.mp4

このように記事は詳細表示されます。記事のいいねとストックは非同期で行えます。下部には、「あなたへのおすすめの記事」が表示されます。これは主にタグを基準におすすめ表示されます。同じタグを持った記事が存在しない場合はランダムで記事が表示されます。

## ユーザーページ

https://user-images.githubusercontent.com/78004609/112108513-a23aac00-8bf3-11eb-84c8-df57ecc96470.mp4

投稿に紐づくユーザーをクリックするとユーザーページに遷移します。そこで、そのユーザーが投稿した記事一覧とメッセージボタンとフォローボタンが存在します。

## マイページ
https://user-images.githubusercontent.com/78004609/112108891-2c831000-8bf4-11eb-875f-271532367210.mp4

ヘッダーのアバター画像をクリックすると、マイページへ遷移することができる。その際、自分が投稿した記事、いいねした記事、ストックした記事を表示することができ、またユーザーの行動履歴や、ユーザーの編集のリンクなどが存在します

## 通知機能

https://user-images.githubusercontent.com/78004609/112109279-b4691a00-8bf4-11eb-8c3b-b2dca621bfb0.mp4

新しい通知があった場合は、黄色いアイコンで教えてくれます。ヘッダーのベルマークをクリックすれば、通知一覧に遷移できます。

## DM通知機能

https://user-images.githubusercontent.com/78004609/112109546-1295fd00-8bf5-11eb-9f53-85bee786c1c8.mp4

ユーザーにDMが届いた場合、黄色いアイコンで教えてくれます

## DM機能

https://user-images.githubusercontent.com/78004609/112109771-4f61f400-8bf5-11eb-9c67-68038c37788c.mp4

Action Cableを用いたDM機能を利用することができます。


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
