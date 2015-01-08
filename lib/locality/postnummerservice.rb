require 'csv'
require 'locality/postnummerservice/entry'
require 'locality/postnummerservice/aregion'
require 'locality/postnummerservice/province'
require 'locality/postnummerservice/state'

module Locality
  module Postnummerservice

    def self.aregions
      load
      @aregions
    end

    def self.states
      load
      @states
    end

    def self.provinces
      load
      @provinces
    end

    private

    def self.load
      load! unless loaded?
    end

    def self.loaded?
      !!@loaded
    end

    def self.load!
      @aregions = {}
      @states = {}
      @provinces = {}

      entries do |entry|
        @aregions[entry.aregion_code] ||= []
        @aregions[entry.aregion_code] << entry
        @states[entry.state_code] ||= []
        @states[entry.state_code] << entry
        @provinces[entry.province_code] ||= []
        @provinces[entry.province_code] << entry
      end

      @loaded = true
    end

    def self.entries(&block)
      ::CSV.foreach(::Locality.config.postnummerfilen_path, encoding: encoding) do |row|
        next if row.blank?
        yield Entry.new(row)
      end
    end

    def self.encoding
      'ISO-8859-1:UTF-8'  # from:to
    end

  end
end
