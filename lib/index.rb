require 'rubygems'
require 'dm-core'

# SYNOPSIS

# 
# INDEX FORMAT
# docs(id, url, date, title, content)
# index(word, doc_ids)
# 
# USAGE
# Indexer.store(feed_item)
class Index
  include DataMapper::Resource
  property :id,         Serial
  property :word,       String
  property :doc_ids,    String
  
  def self.create(document_content)
  end
end
