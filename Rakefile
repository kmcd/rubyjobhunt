require 'rake'
require 'rake/testtask'
require 'lib/rubyjobhunt'

task :default => [:test]

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

desc 'Fetch all feeds and index their job posts'
task :index_jobs do
  Feed.job_posts.each {|job_post| JobPost.create(job_post) }
end

desc 'Wipe db data & re-create schema'
task :migrate_db do
  DataMapper.auto_migrate!
end