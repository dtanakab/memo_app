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

get '/edit/:id' do
  @id = params[:id]
  @memo = Memo.read(@id)
  erb :edit
end

patch '/edit/:id' do
  @id = params[:id]
  Memo.update(@id, params['memo'])
  redirect "/detail/#{@id}"
end

get '/detail/:id' do
  @id = params[:id]
  @memo = Memo.read(@id)

  erb :detail
end

post '/new' do
  Memo.write(params['memo'].to_s)
  redirect '/'
end

delete '/delete/:id' do
  Memo.delete(params[:id])
  redirect '/'
end
