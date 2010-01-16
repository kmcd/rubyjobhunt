xml.instruct! :xml, :version => '1.1'

xml.rss("version" => "0.91") do
  xml.channel do
    xml.title "RubyJobHunt.com: Your source for all Ruby and Ruby on Rails jobs."
    xml.link  "http://rubyjobhunt.heroku.com/"
    @jobs.each do |job|
      xml.item do
        xml.title job.title
        xml.link  job.url
        xml.description job.content
      end
    end
  end
end
