require 'locality/postnummerservice'
require 'locality/postnummerservice/collection'

module Locality
  # See https://sv.wikipedia.org/wiki/A-region
  class Aregion
    include Postnummerservice::Collection

    def code
      raw_code.to_i
    end

    def state_name
      state_names.first
    end

    private

    def backend
      Locality::Postnummerservice.aregions
    end

  end
end
