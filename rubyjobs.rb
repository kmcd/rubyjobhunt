require 'rubygems'
require 'sinatra'
require 'feed_tools'

# Feed agregator for ruby jobs
FEED_URLS = %w( http://feedproxy.google.com/jobsrubynow )

get '/' do
  # Render list of latest feed items
  @jobs = FEED_URLS.map {|url| FeedTools::Feed.open(url) }.map {|f| f.items }.flatten
  erb :index
end