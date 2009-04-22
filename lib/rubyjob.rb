require 'rake'
require 'dm-core'
require "#{Dir.pwd}/lib/rubyjob/post"
require "#{Dir.pwd}/lib/rubyjob/feed"

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://rubyjobs.db')
DataMapper::Logger.new(STDOUT, 0)

# FIXME: If there are no tables, create & populate
DataMapper.auto_upgrade!
