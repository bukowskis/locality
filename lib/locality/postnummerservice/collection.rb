require 'active_support/concern'

module Locality
  module Postnummerservice
    module Collection
      extend ActiveSupport::Concern

      module ClassMethods
        def backend
          fail NotImplementedError
        end
      end

      def initialize(raw_code)
        @raw_code = raw_code
      end

      # Convert raw_code to code
      def code
        fail NotImplementedError
      end

      def zip_codes
        @zip_codes ||= entities.map(&:zip_code).uniq.sort
      end

      def city_names
        @city_names ||= entities.map(&:city_name).uniq.sort
      end

      def state_codes
        @state_codes ||= entities.map(&:state_code).uniq.sort
      end

      def state_names
        @state_namess ||= entities.map(&:state_name).uniq.sort
      end

      def province_names
        @province_names ||= entities.map(&:province_name).uniq.sort
      end

      def province_codes
        @province_codes ||= entities.map(&:province_code).uniq.sort
      end

      def aregion_codes
        @aregions ||= entities.map(&:aregion_code).uniq.sort
      end

      private

      attr_reader :raw_code

      def entities
        backend[code] || []
      end

      def backend
        self.class.backend
      end

    end
  end
end
