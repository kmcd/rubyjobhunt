# Feed agregator for ruby jobs

require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

get '/search' do
end