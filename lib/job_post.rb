require 'db_config'
require 'dm-timestamps'
require 'feed_tools'
require 'active_support'

# TODO: rename to JobPost
class JobPost
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String, :length => 255, :required => true, :unique => true
  property :title, String, :length => 255
  property :date, Date
  property :content, Text
  property :created_on, Date
  
  before :save, :strip_markup
  
  def self.latest
    all :order => :date, :order => [ :date.desc ], :date.gt => 6.weeks.ago
  end
  
  def self.create(feed_entry)
    new( :url => feed_entry.link,
      :title    => feed_entry.title, 
      :date     => feed_entry.published.to_date.to_s, 
      :content  => feed_entry.content ).save
  end
  
  private
  
  # TODO: use a gem for html stripping
  def strip_markup
    attribute_set :title, strip_markup_from(title)
    attribute_set :content, strip_markup_from(content)
  end
  
  def strip_markup_from(content)
    return unless content
    FeedTools::HtmlHelper.convert_html_to_plain_text(content).gsub /(\W|\d)/, ' '
  end
end
