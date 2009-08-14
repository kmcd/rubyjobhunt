require File.dirname(__FILE__) + '/test_helper'

class IndexTest < Test::Unit::TestCase
  def setup
    Index.all.destroy!
  end
  
  should "store keyword and its document id" do
    Index.store 1, 'foo'
    assert_equal 1.to_s, Index.first(:word => 'foo').doc_ids
  end
  
  should "extract keywords from content" do
    Index.store 1, 'foo and bar'
    assert_equal 'foo bar', Index.all.map {|i| i.word }.join(' ')
  end
  
  should "have unique keyword" do
    2.times { Index.store(1, 'foo') }
    assert_equal 1, Index.all.size
  end
  
  should "update keyword if it appears in multiple documents " do
    [1, 2].each {|doc_id| Index.store(doc_id, 'foo') }
    assert_equal '1,2', Index.first(:word => 'foo').doc_ids
  end
end
