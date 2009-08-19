# Ruby job search engine
require 'rubygems'
require 'sinatra'
require 'lib/index'

get '/' do
  @jobs = Index.search params[:q]
  erb :results
end