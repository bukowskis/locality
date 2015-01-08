require 'locality/postnummerservice'
require 'locality/postnummerservice/collection'

module Locality
  module Postnummerservice
    class State
      include Postnummerservice::Collection

      # See http://www.scb.se/Pages/List____257281.aspx
      def self.codes
        Hash[backend.map { |code, entries| [code, entries.first.state_name] }]
      end

      def code
        raw_code.to_i
      end

      def name
        state_names.first
      end

      private

      def self.backend
        Postnummerservice.states
      end

    end
  end
end