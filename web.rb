#!/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'redis'

set :bind, '0.0.0.0'

# Configure Redis
$Redis = Redis.new(
  host: ENV['REDIS_PORT_6379_TCP_ADDR'],
  port: ENV['REDIS_PORT_6379_TCP_PORT']
)

get '/' do
  count = $Redis.incr('request_count')
  json count: count
end
