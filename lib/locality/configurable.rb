require 'locality/configuration'

module Locality
  module Configurable

    # Public: Returns the the configuration instance.
    #
    def config
      @config ||= Configuration.new
    end

    # Public: Yields the configuration instance.
    #
    def configure(&block)
      yield config
    end

    # Public: Reset the configuration (useful for testing)
    #
    def reset!
      @config = nil
    end

  end
end
