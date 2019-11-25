# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'
require_relative 'app_memo'

memoes = {}
id_count = 1

get '/' do
  @memoes = memoes
  erb :top
end

get '/add' do
  erb :add_memo
end

get '/edit/*' do |id|
  @id = id
  @memo = memoes[id].read
  erb :edit
end

patch '/edit/*' do |id|
  @id = id
  memoes[id].update(params[:memo])
  redirect "/detail/#{id}"
end

get '/detail/*' do |id|
  @id = id
  @memo = memoes[id].read
  erb :detail
end

post '/new' do
  @id = id_count.to_s
  memoes[@id] = Memo.new(@id, params[:memo])
  id_count += 1
  redirect '/'
end

delete '/delete/*' do |id|
  memoes[id].delete
  memoes.delete(id)
  redirect '/'
end
