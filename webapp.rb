# Feed agregator for ruby jobs

require 'rubygems'
require 'sinatra'
require 'feed_tools'
require 'rubyjob'

get '/' do
  # Render list of latest feed items
  @jobs = RubyJob.latest
  erb :index
end

get '/search' do
  @jobs = RubyJob.search(params[:q])
  erb :index
end