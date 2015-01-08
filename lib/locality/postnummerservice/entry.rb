require 'active_support/core_ext/string'

module Locality
  module Postnummerservice
    class Entry < Array

      def zip_code
        self[0].to_i
      end

      def city_name
        self[1].to_s.mb_chars.downcase.titleize.to_s
      end

      def state_code
        self[2].to_i
      end

      def state_name
        self[3].to_s.mb_chars.downcase.titleize.to_s
      end

      def province_name
        self[4].to_s.mb_chars.downcase.titleize.to_s
      end

      def province_code
        self[5]
      end

      def aregion
        self[6].to_i
      end

    end
  end
end
