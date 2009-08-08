require 'rubygems'
require 'dm-core'

DataMapper.setup :default, 
  :adapter => "postgres", 
  :database => "rubyjobhunt_development"
