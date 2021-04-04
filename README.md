#  ![logo](https://user-images.githubusercontent.com/76896952/112626502-a412a280-8e73-11eb-8c87-4da6262463b9.png)

## サイト概要
観た映画の感想を投稿するサイトです。<br>
人の感想に共感したものにはいいねやコメントをすることができます。<br>
気になったユーザーをフォローすることができます。<br>
<img width="1147" alt="image" src="https://user-images.githubusercontent.com/76896952/113505863-59cca800-957c-11eb-8d00-cfb1848320a0.png">


### URL
https://mymovielife.work/ <br>
新規登録画面、ログイン画面にあるGuest login（For viewing）ボタンから<br>
メールアドレスとパスワードを入力せずにログインできます。

### 制作の背景
映画が見放題の動画配信のサブスクリプションサービスが普及し、さらに外出自粛により、家で映画を観ることが増えた人も多いのではないかと思います。<br>
そんな方々が気軽に映画の感想を伝えるサイトがあれば良いなと思い、制作しました。<br>
また、利用者が自分の感想を人と共有することで、新たな価値観や気づきに出会えるのではないかと考えました。

### ターゲットユーザ
映画が好きな人

### 主な利用シーン
- 映画を観たあと、誰かに感想を伝えたいとき
- 観た映画の感想を記録したいとき

## 機能一覧
https://docs.google.com/spreadsheets/d/1KZ4hJAV8E86cj_TwJGsXJLAJT5NKLnJzPrVeP6sLGkk/edit#gid=2076875427
- ユーザー認証、SNS認証
- 投稿機能、画像アップロード
- タグ付け機能
- コメント機能
- いいね機能
- フォロー機能
- 通知機能
- 検索機能
- お問い合わせ機能
- レスポンシブデザイン<br>
<span>![responsive1](https://user-images.githubusercontent.com/76896952/113506268-b3ce6d00-957e-11eb-80e0-fd100908e299.jpg)</span>
<span>![responsive2](https://user-images.githubusercontent.com/76896952/113506273-b7fa8a80-957e-11eb-9f0d-3befc57cf458.jpg)</span>
<span>![responsive3](https://user-images.githubusercontent.com/76896952/113506277-ba5ce480-957e-11eb-8420-0169774f3329.jpg)</span>

## 環境・使用技術
### フロントエンド
- HTML、CSS
- Bootstrap 4.5.0
- JavaScript、jQuery、Ajax
### バックエンド
- Ruby 2.6.3
- Rails 5.2.4.5
### インフラ
- AWS（Cloud9、EC2、RDS、Route53）
- MySQL2
- Nginx、Puma
- CircleCi CI/CD