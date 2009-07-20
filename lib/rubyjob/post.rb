class RubyJob::Post
  include DataMapper::Resource
  
  property :id,           Integer, :serial => true
  property :url,          String,  :unique => true
  property :title,        String
  property :description,  String
  property :published,    Date
  
  def published=(date)
    date.strftime "%A %B %d %Y"
  end
  
  def posting(content)
    content.gsub /(\n|\n\n+)/, '<br/>'
  end
end