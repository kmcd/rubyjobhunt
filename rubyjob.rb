class RubyJob
  include FeedTools
  
  # TODO: persist feed url storage
  FEED_URLS = %w( 
    http://feedproxy.google.com/jobsrubynow 
    http://sfbay.craigslist.org/search/jjj?query=ruby&addOne=telecommuting&format=rss
    http://railswork.com/jobs/all.rss
  )
  
  # TODO: persist feed items
  # TODO: update feed items hourly (cronjob)
  def self.latest
    @jobs = FEED_URLS.map {|url| Feed.open(url) }.
      map {|f| f.items }.flatten.map {|i| RubyJob.new(i) }
  end
  
  def self.search(params)
    all
  end
  
  def initialize(feed_item)
    @item = feed_item
  end
  
  def title
    @item.title
  end
  
  def published
    @item.published.strftime "%A %B %d %Y"
  end
  
  def posting
    @item.content.gsub /(\n|\n\n+)/, '<br/>'
  end
  
  def link
    @item.link
  end
  
  def feed
    @item.base_uri
  end
end
