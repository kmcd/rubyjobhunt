# Ruby job search engine

require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

get '/search' do
end