# Ruby job search engine
require 'rubygems'
require 'sinatra'
require 'lib/rubyjobhunt'

get '/' do
  @jobs = Document.latest
  erb :results
end