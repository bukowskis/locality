require 'active_support/core_ext/object/blank'
require 'ipaddr'
require 'operation'
require 'trouble'
require 'geocoder'
require 'hashie/mash'

require 'locality/configurable'

module Locality
  class IP

    def initialize(raw_ip)
      @raw_ip = raw_ip
    end

    def self.check!
      if Locality.config.maxmind_geoip2_path.blank?
        fail download_message
      end

      # Just checking to see if it causes any trouble notiications, but not depending on it
      new('8.8.8.8').country_name
    end

    def to_hash
      {
        ip: ip.to_s,
        city_name: city_name,
        province_name: province_name,
        state_name: state_name,
        country_name: country_name,
        human_readable_location: human_readable_location,
      }
    end

    def ip
      @ip ||= ::IPAddr.new(raw_ip.to_s)
    rescue => exception
      nil
    end

    def human_readable_location
      city_name || province_name || state_name || country_name
    end

    def coordinates
      return unless lookup
      lookup.coordinates.presence
    rescue => exception
    end

    def latitude
      return unless lookup
      lookup.latitude.presence
    rescue => exception
    end

    def longitude
      return unless lookup
      lookup.longitude.presence
    rescue => exception
    end

    def city_name
      return unless lookup
      lookup.city.presence
    rescue => exception
    end

    def province_name
      return unless lookup
      lookup.province.presence
    rescue => exception
    end

    def state_name
      return unless lookup
      lookup.state.presence
    rescue => exception
    end

    def country_name
      return unless lookup
      lookup.country.presence
    rescue => exception
    end

    private

    attr_reader :raw_ip

    def lookup
      @lookup ||= custom_lookup! || lookup!
    end

    def lookup!
      return unless ip.present?
      ensure_upstream_configuration
      Geocoder::Lookup.get(:geoip2).search(ip.to_s).first

    rescue IOError => exception
      Trouble.notify exception
      configure_upstream!  # Maybe the database file just moved somewhere else, repair by force-reconfiguring
      nil
    end

    def custom_lookup!
      ::Locality.config.custom_ip_locations.each do |key, value|
        next unless key.include? ip
        input = Hashie::Mash.new value
        # Quacking like Geocoder::Result::GeoIP2
        return Hashie::Mash.new(city: input.city_name, province: input.province_name, state: input.state_name, country: input.country_name)
      end
      nil
    end

    def ensure_upstream_configuration
      return if Geocoder.config[:ip_lookup] == :geoip2
      configure_upstream!
    end

    def configure_upstream!
      Geocoder.configure ip_lookup: :geoip2, units: :km, geoip2: { file: ::Locality.config.maxmind_geoip2_path }
    end

    def self.download_message
      <<END


      Please download this file:

          http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz

      And put it into one of the following locations

          #{Locality.config.maxmind_geoip2_paths.join("\n          ")}

      You can use the following command to do so:

      curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -o #{Locality.config.maxmind_geoip2_paths.first} && gunzip #{Locality.config.maxmind_geoip2_paths.first}

END
    end

  end
end
