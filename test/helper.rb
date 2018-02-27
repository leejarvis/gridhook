ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path '../dummy/config/environment', __FILE__

require 'minitest/autorun'
require_relative '../lib/gridhook'

class TestCase < Minitest::Test
  def self.test(name, &block)
    define_method("test_#{name.gsub(/\W/, '_')}", &block) if block
  end
end