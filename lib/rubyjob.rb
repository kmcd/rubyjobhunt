require 'rake'
require 'dm-core'
# TODO: simplify lib loading
require "#{Dir.pwd}/lib/rubyjob/post"
require "#{Dir.pwd}/lib/rubyjob/feed"

DataMapper.setup(:default, 'sqlite3::memory')
DataMapper::Logger.new(STDOUT, 0)

DataMapper.auto_upgrade!
