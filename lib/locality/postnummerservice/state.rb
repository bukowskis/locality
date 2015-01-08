require 'locality/postnummerservice'
require 'locality/postnummerservice/collection'

module Locality
  module Postnummerservice
    class State
      include Postnummerservice::Collection

      # See http://www.scb.se/Pages/List____257281.aspx
      def self.codes
      end

    end
  end
end
