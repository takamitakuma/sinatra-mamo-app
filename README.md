# Memoアプリ
sinatraを使って作った簡単なメモアプリです。

# 環境
Ruby 3.0.0
sinatra 2.1.0

# 機能
このアプリには以下の機能があります。
- 新規メモを追加することができます。
- 作成したメモは一覧画面で表示させることができます。
- メモの個別ページから、対象のメモの削除と変更が可能です。

# 使い方
1. 使用PCの作業ディレクトリに`git clone`します。
2. 使用環境にbundlerがインストールされていない場合、`gem install bundler`でbundlerをインストールしてください。
3. `bundle install`で、Gemfileに記載があるGemをインストールしてください。
4. `bundle exec ruby app.rb`でアプリを実行します。
5. ブラウザを開き、`localhost:4567/memos`にアクセスするとアプリが表示されます。

このアプリはPostgreSQLを使っています。
アプリを実行する前に`memo`という名前のテーブルを作成して下さい。
1. `psql -U ユーザ名`でPostgreSQLにログインしてください。
2. `CREATE DATEBASE memo;`を実行し、データベースを作成します。
3. `quit`で一度psqlを終了してください。
4. `psql -U ユーザ名 memo`でmemoに接続します。
5. `CREATE TABLE memo(id VARCHAR(36) NOT NULL, title VARCHAR(100), content text, PRIMARY KEY (id));`を実行し、メモテーブルを作成して下さい。
