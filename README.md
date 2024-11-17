# 記録を自由に書いてみよう！

### ER図
![alt text](<スクリーンショット 2024-11-17 142326.png>)

■サービス概要
MR（製薬会社の営業）むけの顧客管理アプリ。
営業担当のクリニックを登録し、医師が使用している製品や活動内容を記録することで、効率の良い営業活動につなげるツール。

■ このサービスへの思い・作りたい理由
自信がMRの仕事に従事しており、日々の活動の中でMRに特化した顧客管理アプリがあればいいと思うことが多いので作ることにした。ルート営業では毎回話のタネが見つからないが、このアプリを見れば何を話せばいいかアイデアがわくような作りにしたい。
シンプルでわかりやすいアプリを作って営業活動を効率的に行いたい。

■ ユーザー層について
MR職、または、医師向けに営業活動を行う者。中でもルート営業を行うことが多く「何を話そう？」「話すことないな」と思っている人。

■サービスの利用イメージ
次に医師に会った時に何を話すのがよいか、どの処方をPRすれば購入してもらえそうか、先生のニーズは何かを、即時に確認でき、営業活動の効率化ができる。営業のスケジュールもある程度自動的に決めてくれるので、MRの事務仕事が減り、営業活動に集中できる。

■ ユーザーの獲得について
転職するときに、今の会社のMRに紹介します。

■ サービスの差別化ポイント・推しポイント
顧客管理アプリは他にもあるが、MRに特化したものはほとんどない。
複雑なシステムがなく、シンプルで使いやすい点。

■ 機能候補
## MVP
・ユーザー登録
・ログイン
・クリニック一覧
・クリニック登録
・クリック詳細
・自社製品登録
・自社製品一覧
・面会スケジュール

## その他の機能
・クリニック口コミ機能
・クリニック検索（クリニック名・住所・診療科）
・タスク管理
 ・タスクLINE通知機能
・クリニック位置情報


■ 機能の実装方針予定
一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装する予定なのか現状考えているもので良いので教えて下さい。
・Stimulus Autocomplete（Rails7 ）：マルチ検索。クリニック名・院長名・診療科・使用処方名などからクリニックを検索できるようにしたい。
・LINE Messaging API SDK for Ruby: プッシュ通知。期限付きの提出物やアポイントなどの事務作業の取りこぼしがないように前日に通知がいく仕組みにしたい。
・Geocoder: 位置情報。クリニックの位置・周辺駐車場などが瞬時にわかるようにしたい。

