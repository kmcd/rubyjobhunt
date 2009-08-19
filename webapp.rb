# Ruby job search engine
require 'rubygems'
require 'sinatra'
require 'lib/rubyjobhunt'

get '/' do
  @jobs = Document.all
  erb :results
end