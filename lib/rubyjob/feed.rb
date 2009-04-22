require 'feed_tools'

module RubyJob
  class Feed
    include FeedTools
    include DataMapper::Resource
    
    property :id,   Integer, :serial => true
    property :url,  String,  :unique => true
    
    def self.populate(feeds)
      feeds.each {|feed_url| (new :url => feed_url).save }
    end
    
    def fetch_posts
      Feed.open(self.url).each do |item|
        # Save the post
      end
    end
  end
end