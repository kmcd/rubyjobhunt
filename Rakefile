require 'rake'
require 'rake/testtask'
require 'redgreen'

task :default => [:test]

Rake::TestTask.new do |t|
  t.test_files = FileList['*test.rb']
  t.verbose = true
end

desc "Fetch & index all feeds"
task :index do
  Feed.all.each do |feed|
    Index.store(feed)
  end
end