module Gridhook

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield config
  end

  class Config < Struct.new(:event_processor)
  end

end