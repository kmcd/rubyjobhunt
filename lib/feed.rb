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
    http://railswork.com/jobs/all.rss 
    http://feeds.feedburner.com/RubyInside
    http://feeds.feedburner.com/RailsInside
    http://www.reddit.com/r/ruby/.rss
    http://feeds.feedburner.com/rubyjobsireland
    http://railswork.com/jobs/all.rss
    http://feeds.feedburner.com/RidingRails
    http://jobs.37signals.com/categories/2/jobs.rss
    http://feedproxy.google.com/jobsrubynow
    http://sfbay.craigslist.org/search/jjj?query=ruby&amp;addOne=telecommuting&amp;format=rss
    http://www.indeed.co.uk/rss?q=ruby&amp;l=london )
    
  def self.all
    URLS.map do |feed_url|
      FeedTools::Feed.open(feed_url)
    end
  end
  
  def self.job_posts
    all.map {|feed| feed.entries }.flatten
  end
end