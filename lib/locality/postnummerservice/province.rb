require 'locality/postnummerservice'
require 'locality/postnummerservice/collection'

module Locality
  module Postnummerservice
    class Province
      include Postnummerservice::Collection

      # See http://www.scb.se/Pages/List____257281.aspx
      def self.codes
        Hash[backend.map { |code, entries| [code, entries.first.province_name] }]
      end

      def code
        raw_code.to_s.strip
      end

      def name
        province_names.first
      end

      private

      def self.backend
        Postnummerservice.provinces
      end

    end
  end
end
