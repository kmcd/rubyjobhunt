task :cron => :environment do
  Feed.job_posts.each {|job_post| JobPost.create(job_post) }
end