#!/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'redis'
require 'erb'

enable :logging

set :bind, '0.0.0.0'
set :message, false

# Configure Redis
# $Redis = Redis.new(
#   host: ENV['REDIS_PORT_6379_TCP_ADDR'],
#   port: ENV['REDIS_PORT_6379_TCP_PORT']
# )
$Redis = Redis.new(
  host: ENV['REDIS_HOST'],
  port: ENV['REDIS_PORT']
)

get '/' do
  erb :index, locals: { message: settings.message }
end

get '/count' do
  count = $Redis.incr('request_count')
  json count: count
end

get '/redis' do
  json $Redis.inspect
end

get '/about' do
  'Frank Redis is a Sinatra app with Redis'
end

get '/set-key/:key/:value' do
  $Redis.set(params[:key], params[:value])
  json params
end

post '/set-key' do
  key = params[:key]
  params.delete(:key)
  value = params.to_json
  logger.info "params: #{params.inspect}"
  logger.info "value: #{value}"
  $Redis.set(key, value)

  redirect "/show-key/#{key}"
end

get '/show-key/:key' do
  $Redis.get(params[:key])
end
