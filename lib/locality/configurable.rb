module Locality
  module Configurable

    # Public: Returns the the configuration instance.
    #
    def config
      @config ||= configuration_instance
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

    def configuration_instance
      fail NotImplementedError
    end

  end
end
