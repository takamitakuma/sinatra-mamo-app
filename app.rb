# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'pg'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

conn = PG.connect(
  host: 'localhost',
  dbname: 'memo',
  port: '5432'
)

get '/memos' do
  @memos = conn.exec('SELECT * FROM memo')
  erb :memos
end

get '/memos/new' do
  erb :create_memo
end

post '/memos' do
  id = SecureRandom.uuid
  title = params[:title]
  memo = params[:memo]
  conn.exec('INSERT INTO memo VALUES($1, $2, $3);', [id, title, memo])
  redirect to('/memos')
end

get '/memos/:id' do |id|
  @memo = conn.exec('SELECT * FROM memo WHERE id = $1;', [id])
  erb :show_memo
end

delete '/memos/:id' do |id|
  conn.exec('DELETE FROM memo WHERE id = $1;', [id])
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  @memo = conn.exec('SELECT * FROM memo WHERE id = $1;', [id])
  erb :edit_memo
end

patch '/memos/:id' do |id|
  title = params[:title]
  memo = params[:memo]
  conn.exec('UPDATE memo SET title = $1, content = $2 WHERE id = $3;', [title, memo, id])
  redirect to('/memos')
end
