require "logger"

# Like a normal logger, but you can tell it to be quiet sometimes
class TestLogger
  attr_accessor :quiet
  def initialize
    @logger = Logger.new($stdout)
    @messages = []
    self.quiet = false
  end

  def method_missing(method_name, *args, &block)
    @messages << args
    if !quiet
      @logger.send(method_name, *args, &block)
    end
  end
end
