# Feed agregator for ruby jobs

require 'rubygems'
require 'sinatra'
require 'lib/rubyjob'

get '/' do
  # @jobs = JobPost.latest
  # erb :index
end

get '/search' do
  # @jobs = JobPost.search(params[:q])
  # erb :results
end