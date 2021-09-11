# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/memos' do
  File.open('json/memos.json', 'r') do |file|
    @memos = JSON.parse(file.read)
  end
  erb :memos
end

get '/memos/new' do
  erb :create_memo
end

post '/memos' do
  hash = File.open('json/memos.json') { |file| JSON.parse(file.read) }
  hash[SecureRandom.uuid] = { 'title' => params[:title], 'memo' => params[:memo] }
  json = JSON.pretty_generate(hash)
  File.open('json/memos.json', 'w') { |file| file.puts(json) }
  redirect to('/memos')
end

get '/memos/:id' do |id|
  File.open('json/memos.json', 'r') do |file|
    memos = JSON.parse(file.read)
    @memo = memos[id]
    @id = id
  end
  erb :show_memo
end

delete '/memos/:id' do |id|
  hash = File.open('json/memos.json') { |file| JSON.parse(file.read) }
  hash.delete(id)
  json = JSON.pretty_generate(hash)
  File.open('json/memos.json', 'w') { |file| file.puts(json) }
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  hash = File.open('json/memos.json') { |file| JSON.parse(file.read) }
  @memo = hash[id]
  @id = id
  erb :edit_memo
end

patch '/memos/:id' do |id|
  hash = File.open('json/memos.json') { |file| JSON.parse(file.read) }
  hash[id]['title'] = params[:title]
  hash[id]['memo'] = params[:memo]
  json = JSON.pretty_generate(hash)
  File.open('json/memos.json', 'w') { |file| file.puts(json) }
  redirect to('/memos')
end
