require 'lib/db_config'

# SYNOPSIS
# 
#   INDEX FORMAT
#   docs(id, url, date, title, content)
#   index(word, doc_ids)
# 
# USAGE
#   Index.store(feed_item)
class Index
  STOP_WORDS = /\b(a|able|about|across|after|all|almost|also|am|among|an|and|any|are|as|at|be|because|been|but|by|can|cannot|could|dear|did|do|does|either|else|ever|every|for|from|get|got|had|has|have|he|her|hers|him|his|how|however|i|if|in|into|is|it|its|just|least|let|like|likely|may|me|might|most|must|my|neither|no|nor|not|of|off|often|on|only|or|other|our|own|rather|said|say|says|she|should|since|so|some|than|that|the|their|them|then|there|these|they|this|tis|to|too|twas|us|wants|was|we|were|what|when|where|which|while|who|whom|why|will|with|would|yet|you|your)\b/i
  include DataMapper::Resource
  
  property :id, Serial
  property :word, String, :key => true
  property :doc_ids, Text
  
  # TODO: move to 
  def self.search(params=nil)
    if params
      # Full text boolean search ordered by date
    else
      # All jobs ordered by date
    end
    []
  end
  
  def self.store(doc_id, content)
    keywords_from(content).each {|keyword| create_or_update(doc_id, keyword) }
  end
  
  def self.keywords_from(content)
    content.gsub(STOP_WORDS, '').split.map {|word| word.downcase }.uniq
  end
  
  def self.create_or_update(doc_id, keyword)
    # TODO: investigate algorithmic impact of doing a find on *every* insert
    if existing_keyword = first(:word => keyword)
      existing_keyword.update_doc_ids(doc_id)
    else
      create(:word => keyword, :doc_ids => doc_id)
    end
  end
  
  def update_doc_ids(doc_id)
    update_attributes(:doc_ids => ( doc_ids + ',' + doc_id.to_s ))
  end
end
