require 'rubygems'
require 'dm-core'

DataMapper.setup(:default, :adapter => "postgres", :database => "rubyjobhunt_development" )

class Document
  include DataMapper::Resource
  
  property :id,       Serial
  property :url,      String, :length => 255
  property :title,    String, :length => 255
  property :date,     Date
  property :content,  Text
  
  # Takes a FeedTools::FeedItem and saves to database
  def self.create(feed_entry)
    new.update_attributes :url => feed_entry.guid,
      :title    => feed_entry.title, 
      :date     => feed_entry.published.to_date.to_s, 
      :content  => feed_entry.content
  end
end
