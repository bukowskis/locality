module Locality
  module Postnummerservice
    class ZipCode
      include Postnummerservice::Collection

      def code
        raw_code.to_i
      end

      def state
        Locality::Postnummerservice::State.new(state_code)
      end

      def aregion
        Locality::Postnummerservice::Aregion.new(aregion_code)
      end

      private

      def state_code
        state_codes.first
      end

      def aregion_code
        aregion_codes.first
      end

      def self.backend
        Postnummerservice.zip_codes
      end

    end
  end
end
