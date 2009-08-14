require 'db_config'
require 'index'
require 'dm-timestamps'
require 'feed_tools'

class Document
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String, :length => 255
  property :title, String, :length => 255
  property :date, Date
  property :content, Text
  property :created_on, Date
  
  before :save, :strip_markup
  after :save, :index
  
  # Takes a FeedTools::FeedItem and saves to database
  def self.create(feed_entry)
    new.update_attributes :url => feed_entry.guid,
      :title    => feed_entry.title, 
      :date     => feed_entry.published.to_date.to_s, 
      :content  => feed_entry.content
  end
  
  def index
    Index.store id, indexable_conent
  end
  
  def indexable_conent
    [content, title].join ' '
  end
  
  private
  
  def strip_markup
    attribute_set :title, strip_markup_from(title)
    attribute_set :content, strip_markup_from(content)
  end
  
  def strip_markup_from(content)
    return unless content
    FeedTools::HtmlHelper.convert_html_to_plain_text(content).gsub /(\W|\d)/, ' '
  end
end
