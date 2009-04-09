# Feed agregator for ruby jobs

require 'rubygems'
require 'sinatra'
require 'feed_tools'

get '/' do
  # Render list of latest feed items
  @jobs = RubyJob.all
  erb :index
end

# Search feeds
# get '/search/:params' {}

# Add a feed
# post '/' {}


class RubyJob
  include FeedTools
  # TODO: persist feed url storage
  # TODO: cache feed items
  # TODO: update feed items hourly
  FEED_URLS = %w( http://feedproxy.google.com/jobsrubynow )
  
  def self.all
    @jobs ||= FEED_URLS.map {|url| Feed.open(url) }.map {|f| f.items }.flatten
  end
  
  def title
  end
  
  def description
  end
  
  def link
  end
  
  def feed_url
  end
end