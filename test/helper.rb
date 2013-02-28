ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path '../dummy/config/environment', __FILE__

require 'minitest/autorun'

unless Object.const_defined? 'Gridhook'
  $:.unshift File.expand_path('../../lib', __FILE__)
  require 'gridhook'
end

class TestCase < MiniTest::Unit::TestCase
  def self.test(name, &block)
    define_method("test_#{name.gsub(/\W/, '_')}", &block) if block
  end
end