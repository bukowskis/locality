require 'active_support/core_ext/object/blank'
require 'ipaddr'
require 'operation'
require 'trouble'
require 'geocoder'

require 'locality/ip/configuration'
require 'locality/configurable'

module Locality
  class IP
    extend Configurable

    def initialize(raw_ip)
      @raw_ip = raw_ip
    end

    def self.configuration_instance
      Configuration.new
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
      @ip ||= ::IPAddr.new raw_ip
    rescue => exception
      Trouble.notify exception
      nil
    end

    def human_readable_location
      city_name || province_name || state_name || country_name
    end

    def city_name
      return unless lookup
      lookup.city.presence
    end

    def province_name
      return unless lookup
      lookup.province.presence
    end

    def state_name
      return unless lookup
      lookup.state.presence
    end

    def country_name
      return unless lookup
      lookup.country.presence
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
      ::Trouble.notify exception
      configure_upstream!  # Maybe the database file just moved somewhere else, repair by force-reconfiguring
      nil
    end

    def custom_lookup!
      self.class.config.custom_locations.each do |key, value|
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
      Geocoder.configure ip_lookup: :geoip2, units: :km, geoip2: { cache: Hash.new, lib: 'hive_geoip2', file: self.class.config.maxmind_geoip2_path }
    end

  end
end
