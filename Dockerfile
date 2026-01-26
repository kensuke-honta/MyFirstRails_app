# 1. ベースイメージの指定 (Ruby)
FROM ruby:3.2.2

# 2. 依存パッケージのインストール
# libpq-dev: PostgreSQL接続用, nodejs/yarn: フロントエンドビルド用
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

# 3. 作業ディレクトリの設定
WORKDIR /app

# 4. Gemのインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 5. アプリケーションファイルのコピー
COPY . .

# 6. サーバー起動時のPIDクリア用スクリプト
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
