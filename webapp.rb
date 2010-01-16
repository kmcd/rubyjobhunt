require 'rubygems'
require 'sinatra'
require 'lib/rubyjobhunt'

# Display the last 6 weeks jobs from all ruby job feeds

get '/' do
  @jobs = Document.latest
  erb :results
end