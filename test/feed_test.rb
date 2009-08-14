require File.dirname(__FILE__) + '/test_helper'

class FeedUrlTest < Test::Unit::TestCase
  should "store all feed urls" do
    assert_kind_of Array, Feed::URLS
    assert !Feed::URLS.empty?
  end
  
  test "all feed urls are valid URI's" do
    assert Feed::URLS.all? {|url| url.match /http\:\/\/(\w|\.)+\w{2,3}\/\w+/ }
  end
end

class FeedFetchTest < Test::Unit::TestCase
  def setup
    flexmock FeedTools::Feed, :open => FeedTools::FeedItem.new
  end
  
  test "all feeds returns an array" do
    assert_kind_of Array, Feed.all
  end
  
  test "should be an array of feeds" do
    Feed.all.each {|feed| assert_kind_of FeedTools::FeedItem, feed }
  end
  
  test "should fetch all feeds stored in URLs" do
    feed = flexmock FeedTools::Feed
    feed.should_receive(:open).with(Feed::URLS.join(','))
    # TODO: investigate why times(2) isn't working
    Feed.all
  end
end