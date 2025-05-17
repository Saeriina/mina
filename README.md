# プロジェクト名：『Clinico』
<img width="500" src="app/assets/images/clinico.jpg"><br>
<br>

# 目次
- [サービス概要](#-サービス概要)
- [サービスURL](#-サービスurl)
- [サービス開発の背景](#-サービス開発の背景)
- [機能紹介](#-機能紹介)
- [使用技術](#-使用技術)
- [ER図](#-er図)<br>
<br>

# ■ サービス概要
MRのための顧客管理・スケジュール管理アプリ。
営業担当のクリニックを登録し、医師が使用している製品や活動内容を記録することで、効率の良い営業活動につなげることができます。また、訪問スケジュールを自動作成することができ、MRにとって非効率な事務作業を削減することができるツールです。

# ■ サービスURL
https://mina.fly.dev/

# ■ サービス開発の背景
MRとは製薬会社で自社製品の普及や情報提供に努める専門職です。
自身がMR活動に携わる中で、顧客管理やスケジュール管理を効率的にできるシステムが欲しい！という思いからこのアプリの制作を始めました。既にあるMR活動支援のためのアプリは広範囲で包括的なシステムが多く、必要最低限でシンプルなものがありませんでした。
<br>
『Clinico』は比較的小規模な製薬会社のMRのための、シンプルで使いやすい顧客管理・スケジュール管理アプリです。
<br>

# ■ 機能紹介
- ユーザー登録/ログイン

| [![Image from Gyazo](https://i.gyazo.com/7d6b30852ed625d6bad0a70b717c54b2.png)](https://gyazo.com/7d6b30852ed625d6bad0a70b717c54b2) |
| <p align="left">『名前』『メールアドレス』『パスワード』『確認用パスワード』を入力してユーザー登録を行います。ユーザー登録後は、自動的にログイン処理が行われるようになっており、そのまま直ぐにサービスを利用する事が出来ます。<br>また、Googleアカウントを用いてGoogleログインを行う事も可能です。</p> |
<br>

- クリニック登録

| [![Image from Gyazo](https://i.gyazo.com/e6ee6bdd1fc0d883413a42c061358092.gif)](https://gyazo.com/e6ee6bdd1fc0d883413a42c061358092) |<br>
左のサイドバーからクリニック登録ページへ。<br>
| [![Image from Gyazo](https://i.gyazo.com/38651c89530d3d1615f7405c860f38c2.gif)](https://gyazo.com/38651c89530d3d1615f7405c860f38c2) |
 <p align="left">『クリニック名』『ドクター名』『クリニックホームページURL』『住所』『訪問可能曜日』『訪問可能時間』『訪問頻度』を入力し、クリニックを登録を行います。住所を登録することで、クリニック詳細画面にてGoogleMapで位置を確認することができます。<p> 
<br>

- クリニック一覧
 
| [![Image from Gyazo](https://i.gyazo.com/fb0bc3ecb2ab62ea39c792b8906c0a9a.gif)](https://gyazo.com/fb0bc3ecb2ab62ea39c792b8906c0a9a) |
 <p align="left">登録したクリニックの一覧を見ることができます。クリニック名をクリックすると詳細画面に遷移します。また、編集・削除も行うことができます。クリニックのホームページのURLを登録した場合は、一覧画面にそのページが表示されています。<p> 
<br>

- クリック詳細

| [![Image from Gyazo](https://i.gyazo.com/ec83f8f1e60ce1396b5506513fcce62f.png)](https://gyazo.com/ec83f8f1e60ce1396b5506513fcce62f) |<br>
登録したクリニックの情報を確認できます。<br>
| [![Image from Gyazo](https://i.gyazo.com/6708ff841861fd3688967dae545cea6c.gif)](https://gyazo.com/6708ff841861fd3688967dae545cea6c) |
 <p align="left">住所を登録した場合はGoogleMapで位置が表示されています。編集・削除も行うことができます。<p> 
<br>

- 製品登録

| [![Image from Gyazo](https://i.gyazo.com/165248376d5eae4600f0831807426d05.gif)](https://gyazo.com/165248376d5eae4600f0831807426d05) |
 <p align="left">『製品名』『製品番号』『適応病名』を入力し、製品登録を行います。<p> 
<br>

- 製品一覧

| [![Image from Gyazo](https://i.gyazo.com/58baae81e556f6c167e2c2e853dc44a3.gif)](https://gyazo.com/58baae81e556f6c167e2c2e853dc44a3) |
 <p align="left">登録した製品の一覧を見ることができます。<p> 
<br>

- タスク管理

| [![Image from Gyazo](https://i.gyazo.com/a26726c638e6267bc39781683d9d0988.gif)](https://gyazo.com/a26726c638e6267bc39781683d9d0988) |
 <p align="left">スケジュールの管理と提出物の管理を行います。「スケジュールを作成」ボタンを押すと今日から二か月分のスケジュールが表示されます。<p>
| [![Image from Gyazo](https://i.gyazo.com/00bae01abe093661f213adebe4a0e703.gif)](https://gyazo.com/00bae01abe093661f213adebe4a0e703) |
 <p align="left">スケジュール作成ページの「スケジュール自動作成」ボタンを押すと、クリニックの訪問可能曜日・時間の欄に、訪問頻度日数を考慮してスケジュールが自動作成されます。<br>個々にクリニック名を入れ手動でスケジュールを作成することもできます。<p> 
<br>

# ■ 使用技術
- **サーバーサイド**：Ruby on Rails 7.2.2 / Ruby 3.2.3  
- **フロントエンド**：Hotwire（Turbo / Stimulus）  
- **CSSフレームワーク**：Bootstrap  
- **Web API連携**：Google API  
- **データベース**：PostgreSQL  
- **アプリケーションサーバー**：Fly.io  
- **バージョン管理**：Git / GitHub（Git Flow 運用）
<br>

# ■ ER図
https://gyazo.com/d431c3f341bc3446f58e8127415746f0
<br>
