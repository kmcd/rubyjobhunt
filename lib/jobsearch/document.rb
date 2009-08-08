require 'index'

class Document
  include DataMapper::Resource
  
  property :id,       Serial
  property :url,      String, :length => 255
  property :title,    String, :length => 255
  property :date,     Date
  property :content,  Text
  
  after :save, :index
  
  # Takes a FeedTools::FeedItem and saves to database
  def self.create(feed_entry)
    new.update_attributes :url => feed_entry.guid,
      :title    => feed_entry.title, 
      :date     => feed_entry.published.to_date.to_s, 
      :content  => strip_markup(feed_entry.content)
  end
  
  def index
    # TODO: should include the title
    Index.store(id, content)
  end
  
  private
  
  def self.strip_markup(text)
    FeedTools::HtmlHelper.convert_html_to_plain_text(text).gsub /(\W|\d)/, ' '
  end
end
