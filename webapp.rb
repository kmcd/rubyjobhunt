require 'rubygems'
require 'sinatra'
require 'lib/rubyjobhunt'

# Display the last 6 weeks jobs from all ruby job feeds
get '/' do
  @jobs = JobPost.latest
  erb :results
end

get '/feed.rss' do
  @jobs = JobPost.latest
  builder :results
end