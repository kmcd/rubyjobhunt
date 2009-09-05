require File.dirname(__FILE__) + '/test_helper'

class DocumentTest < Test::Unit::TestCase
  MARKUP = '<p>We need ruby devs</p> like now!'
  
  def setup
    @doc = Document.new
  end
  
  test "should have a url" do
    assert @doc.update_attributes(:url => 'http://foo.com/bar.rss')
  end
  
  test "should have a date" do
    @doc.save
    assert_equal Date.today, @doc.created_on
  end
  
  test "should strip markup from content" do
    @doc.update_attributes(:content => MARKUP)
    assert_equal 'We need ruby devs like now ', @doc.content
  end
  
  test "should strip markup from title" do
    @doc.update_attributes(:title => MARKUP)
    assert_equal 'We need ruby devs like now ', @doc.title
  end
  
  test "should index content & title" do
    Index.should_receive(:store).with('foo bar')
    @doc.update_attributes(:content => 'foo', :title => 'bar')
  end
end

class CurrentDocumentTest < Test::Unit::TestCase 
  test "should fetch jobs posted today" do
    # d = Document.create :date => Date.today
    # assert_equal [d.id], Document.today
  end
  
  test "should not fetch jobs posted before today" do
    # Document.create :date => Date.today - 1
    # assert_equal [], Document.today
  end
end
