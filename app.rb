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
    @memos = JSON.load(file)
  end
  erb :memos
end

get '/memos/new' do
  erb :memos_new
end

post '/memos' do
  hash = File.open('json/memos.json') { |file| JSON.load(file) }
  hash[SecureRandom.uuid] = { "title" => params[:title], "memo" => params[:memo] }
  json = JSON.pretty_generate(hash)
  File.open('json/memos.json', 'w') { |file| file.puts(json) }
  redirect to('/memos')
end

get '/memos/:id' do |id|
  File.open('json/memos.json', 'r') do |file|
    memos = JSON.load(file)
    @memo = memos[id]
    @id = id
  end
  erb :show_page
end

delete '/memos/:id' do |id|
  hash = File.open('json/memos.json') { |file| JSON.load(file) }
  hash.delete(id)
  json = JSON.pretty_generate(hash)
  File.open('json/memos.json', 'w') { |file| file.puts(json) }
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  hash = File.open('json/memos.json') { |file| JSON.load(file) }
  @memo = hash[id]
  @id = id
  erb :edit_memo
end

patch '/memos/:id' do |id|
  hash = File.open('json/memos.json') { |file| JSON.load(file) }
  hash[id]["title"] = params[:title]
  hash[id]["memo"] = params[:memo]
  json = JSON.pretty_generate(hash)
  File.open('json/memos.json', 'w') { |file| file.puts(json) }
  redirect to('/memos')
end
