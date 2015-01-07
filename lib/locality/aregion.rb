require 'locality/postnummerservice'

module Locality
  # See https://sv.wikipedia.org/wiki/A-region
  class Aregion

    def initialize(raw_code)
      @raw_code = raw_code
    end

    def zip_codes
      @zip_codes ||= backend.aregions[1].map(&:zip_code)
    end

    private

    def backend
      Locality::Postnummerservice
    end

  end
end
