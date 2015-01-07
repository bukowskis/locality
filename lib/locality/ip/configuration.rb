require 'pathname'

module Locality
  class IP
    class Configuration

      attr_writer :maxmind_geoip2_path

      def custom_locations
        @custom_locations ||= {}
      end

      def add_custom_location(ip, data)
        custom_locations[IPAddr.new(ip)] = data.to_hash
      end

      def maxmind_geoip2_path
        maxmind_geoip2_paths.detect(&:readable?)
      end

      def maxmind_geoip2_paths
        result = []
        result << relative_maxmind_geoip2_path
        result << rails_maxmind_geoip2_path
        result << mnt_maxmind_geoip2_path
        result << custom_maxmind_geoip2_path
        result.compact
      end

      private

      def rails_maxmind_geoip2_path
        return unless defined? Rails
        Rails.root.join 'db', maxmind_geoip2_filename
      end

      def mnt_maxmind_geoip2_path
        Pathname.new('/mnt').join 'databases', maxmind_geoip2_filename
      end

      def relative_maxmind_geoip2_path
        Pathname.new(Dir.pwd).join 'db', maxmind_geoip2_filename
      end

      def custom_maxmind_geoip2_path
        return unless @maxmind_geoip2_path
        Pathname.new @maxmind_geoip2_path
      end

      def maxmind_geoip2_filename
        'GeoLite2-City.mmdb'
      end

    end
  end
end
