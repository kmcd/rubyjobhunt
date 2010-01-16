require 'rubygems'
require 'dm-core'

def environment_db
  "rubyjobhunt_#{ ENV['rubyjobhunt_env'] || 'development'}"
end

DataMapper.setup :default, ENV['DATABASE_URL'] || { :adapter => "postgres", :database => environment_db }
