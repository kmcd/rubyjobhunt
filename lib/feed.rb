require 'rubygems'
require 'feed_tools'

# SYNOPSIS
# Fetch feeds from ruby job websites
# 
# USAGE
# feeds = Fetcher.all
# => [ #<Feed>, #<Feed>, ... ]

class Feed
  URLS = %w(
  http://feedproxy.google.com/jobsrubynow 
  http://railswork.com/jobs/all.rss )

  def self.all
    URLS.map do |feed_url|
      # TODO: timeout & logging
      FeedTools::Feed.open(feed_url)
    end
  end
end