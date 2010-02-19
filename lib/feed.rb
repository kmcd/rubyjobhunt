require 'rubygems'
require 'feed_tools'

# SYNOPSIS
#   Fetch feeds from ruby job websites
# 
# USAGE
#   feeds = Fetcher.all
#   => [ #<Feed>, #<Feed>, ... ]

class Feed
  # TODO: move to yaml file
  URLS = %w(
    http://www.cwjobs.co.uk/JobSearch/RSS.aspx?Keywords=ruby
    http://www.totaljobs.com/JobSearch/RSSLink.aspx?Keywords=ruby
    http://railsjobs.in/jobs.atom
    http://railswork.com/jobs/all.rss 
    http://feeds.feedburner.com/rubyjobsireland
    http://railswork.com/jobs/all.rss
    http://feeds.feedburner.com/RidingRails
    http://jobs.37signals.com/categories/2/jobs.rss
    http://feedproxy.google.com/jobsrubynow
    http://sfbay.craigslist.org/search/jjj?query=ruby&amp;addOne=telecommuting&amp;format=rss
    http://www.indeed.co.uk/rss?q=ruby&amp;l=london )
    
  def self.all
    @all_feeds ||= URLS.map {|feed_url| FeedTools::Feed.open(feed_url) }
  end
  
  def self.job_posts
    @job_posts ||= all.map {|feed| feed.entries }.flatten
  end
end