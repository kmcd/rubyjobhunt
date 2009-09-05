require 'rubygems'
require 'dm-core'

def environment_db
  "rubyjobhunt_#{ ENV['rubyjobhunt_env'] || 'development'}"
end

DataMapper.setup :default,
  :adapter => "postgres", 
  :database => environment_db
