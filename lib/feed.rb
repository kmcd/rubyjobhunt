require 'rubygems'
require 'feed_tools'

# SYNOPSIS
#   Fetch feeds from ruby job websites
# 
# USAGE
#   feeds = Fetcher.all
#   => [ #<Feed>, #<Feed>, ... ]

class Feed
  URLS = %w(
    http://feedproxy.google.com/jobsrubynow
    http://railswork.com/jobs/all.rss )
    # TODO: investigate why rails work isnt't indexing correctly

  def self.all
    URLS.map do |feed_url|
      # TODO: timeout & logging
      FeedTools::Feed.open(feed_url)
    end
  end
  
  def self.job_posts
    all.map {|feed| feed.entries }.flatten
  end
end