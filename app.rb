# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'
require_relative 'app_memo'

get '/' do
  @memo_titles = Memo.index
  erb :top
end

get '/add' do
  erb :add_memo
end

get '/edit/*' do |id|
  @id = id
  @memo = Memo.read(id)
  erb :edit
end

patch '/edit/*' do |id|
  @id = id
  Memo.update(id, params['memo'])
  redirect "/detail/#{id}"
end

get '/detail/*' do |id|
  @id = id
  @memo = Memo.read(id)
  erb :detail
end

post '/new' do
  Memo.write(params['memo'].to_s)
  redirect '/'
end

delete '/delete/*' do |id|
  Memo.delete(id)
  redirect '/'
end
