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

