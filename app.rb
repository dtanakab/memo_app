# frozen_string_literal: true

require 'sinatra'
require 'securerandom'
require 'sinatra/reloader'
require 'fileutils'
require_relative 'app_memo'

memoes = {}

get '/' do
  @memoes = memoes
  erb :top
end

get '/add' do
  erb :add_memo
end

get '/edit/:id' do
  @id = params[:id]
  @memo = memoes[@id].read
  erb :edit
end

patch '/edit/:id' do
  @id = params[:id]
  memoes[@id].update(params[:memo])
  redirect "/detail/#{@id}"
end

get '/detail/:id' do
  @id = params[:id]
  @memo = memoes[@id].read
  erb :detail
end

post '/new' do
  @id = SecureRandom.urlsafe_base64
  memoes[@id] = Memo.new(@id, params[:memo])
  redirect '/'
end

delete '/delete/:id' do
  id = params[:id]
  memoes[id].delete
  memoes.delete(id)
  redirect '/'
end
