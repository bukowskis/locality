require 'pathname'

module Locality
  class Configuration

    # IP

    attr_writer :maxmind_geoip2_path

    def custom_ip_locations
      @custom_ip_locations ||= {}
    end

    def add_custom_ip_location(ip, data)
      custom_ip_locations[IPAddr.new(ip)] = data.to_hash
    end

    def maxmind_geoip2_path
      maxmind_geoip2_paths.detect &:readable?
    end

    def maxmind_geoip2_paths
      paths maxmind_geoip2_filename, custom_maxmind_geoip2_path
    end

    # Postnummerservice

    attr_writer :postnummerfilen_path

    def postnummerfilen_path
      postnummerfilen_paths.detect &:readable?
    end

    def postnummerfilen_paths
      paths postnummerfilen_filename, custom_postnummerfilen_path
    end

    private

    def maxmind_geoip2_filename
      'GeoLite2-City.mmdb'
    end

    def postnummerfilen_filename
      'rec2LK.csv'
    end

    def custom_maxmind_geoip2_path
      return unless @maxmind_geoip2_path
      Pathname.new @maxmind_geoip2_path
    end

    def custom_postnummerfilen_path
      return unless @postnummerfilen_path
      Pathname.new @postnummerfilen_path
    end

    def paths(appendix = nil, additional = nil)
      result = []
      result << Rails.root.join('db', appendix) if defined?(Rails)
      result << Pathname.new('/mnt').join('data', 'maxmind', appendix)
      result << Pathname.new(Dir.pwd).join('db', appendix)
      result << Pathname.new(Dir.pwd).join('../databases', appendix)
      result << additional
      result.compact.uniq
    end

  end
end
