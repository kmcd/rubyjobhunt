require 'test/unit'

# Testing helper libs
require 'rubygems'
require 'redgreen'
require 'flexmock/test_unit'
require 'dm-core'

ENV['rubyjobhunt_env'] = 'test'
require 'lib/rubyjobhunt'
DataMapper.auto_migrate!

# Custom test helpers

class Test::Unit::TestCase
  def teardown
    # [ JobPost, Index, Feed ].each {|model| model.all.destroy! }
  end
end

# From http://github.com/sandal/rbp/blob/master/testing/test_unit_extensions.rb
module Test::Unit
  # Used to fix a minor minitest/unit incompatibility in flexmock
  AssertionFailedError = Class.new(StandardError) unless defined?(AssertionFailedError)
  
  # Expand test "foo", {} to def test_foo; end
  class TestCase
    def self.test(name, &block)
      test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
      defined = instance_method(test_name) rescue false
      raise "#{test_name} is already defined in #{self}" if defined
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk "No implementation provided for #{name}"
        end
      end
    end
    
    # TODO: find a nice way to define more of these in test cases
    def self.should(name, &block)
      test(name, &block)
    end
  end
end

def testing(klass, description, &block)
  test_case = "#{klass}#{description.gsub(/\W/,'')}"
  
  test_case = Class.new(Test::Unit::TestCase) do
    class_eval &block 
  end
end
