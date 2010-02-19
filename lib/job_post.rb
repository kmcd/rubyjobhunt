require 'db_config'
require 'dm-timestamps'
require 'dm-validations'
require 'feed_tools'
require 'active_support'

class JobPost
  include DataMapper::Resource
  WEEKS_TO_INDEX = 2.weeks.ago
  
  property :id, Serial
  property :url, String, :length => 255, :required => true, :unique => true
  property :title, String, :length => 255
  property :date, Date
  property :content, Text
  property :created_on, Date
  
  validates_is_unique :url
  
  before :save, :strip_markup
  
  def self.latest
    all :order => [ :date.desc ], :created_on.gt => WEEKS_TO_INDEX
  end
  
  def self.delete_old
    all(:created_on.lt => WEEKS_TO_INDEX).map &:destroy
  end
  
  def self.create(feed_entry)
    new( :url => feed_entry.link,
      :title    => feed_entry.title, 
      :date     => date_for(feed_entry), 
      :content  => feed_entry.content ).save
    rescue Exception => ex
      puts "Error creating #{feed_entry.link} : #{ex.message}"
  end
  
  private
  
  def date_for(feed_entry)
    return 0.minutes.ago unless feed_entry.published
    feed_entry.published.to_date.to_s
  end
  
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
