# Feed agregator for ruby jobs

require 'rubygems'
require 'sinatra'
require 'lib/rubyjob'

get '/' do
  @jobs = RubyJob::Post.all
  erb :index
end

get '/search' do
  @jobs = RubyJob.search(params[:q])
  erb :index
end