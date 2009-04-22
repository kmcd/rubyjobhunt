require 'rake'
require 'rake/testtask'
require 'redgreen'
require 'lib/rubyjob'

FEED_URLS = %w(
  http://feedproxy.google.com/jobsrubynow 
  http://sfbay.craigslist.org/search/jjj?query=ruby&format=rss
  http://railswork.com/jobs/all.rss )

task :default => [:test]

Rake::TestTask.new do |t|
  t.test_files = FileList['*test.rb']
  t.verbose = true
end

desc "Load feed urls into database"
task :load_feed_urls do
  RubyJob::Feed.populate FEED_URLS
  
  puts "\n== Populated db with feeds:\n\n"
  RubyJob::Feed.all.each {|f| puts "=> #{feed.url}" }
  puts
end

desc "Fetch the lastest job posts for each feed"
task :lastest_job_posts do
  RubyJob::Feed.all.each {|feed| feed.fetch_posts }
end