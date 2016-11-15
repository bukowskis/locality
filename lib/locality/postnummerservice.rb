require 'csv'
require 'locality/postnummerservice/entry'
require 'locality/postnummerservice/aregion'
require 'locality/postnummerservice/province'
require 'locality/postnummerservice/state'
require 'locality/postnummerservice/zip_code'

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

    def self.zip_codes
      load
      @zip_codes
    end

    private

    def self.load
      load! unless loaded?
    end

    def self.loaded?
      !!@loaded
    end

    # Useful for testing
    def self.reset!
      @loaded = false
      @aregions = {}
      @states = {}
      @provinces = {}
      @zip_codes = {}
    end

    def self.load!
      reset!
      entries do |entry|
        @aregions[entry.aregion_code] ||= []
        @aregions[entry.aregion_code] << entry
        @states[entry.state_code] ||= []
        @states[entry.state_code] << entry
        @provinces[entry.province_code] ||= []
        @provinces[entry.province_code] << entry
        @zip_codes[entry.zip_code] ||= []
        @zip_codes[entry.zip_code] << entry
      end

      @loaded = true
    end

    def self.entries(&block)
      return [] unless path

      ::CSV.foreach(path, encoding: encoding, col_sep: ';') do |row|
        next if row.blank?
        yield Entry.new(row)
      end

    rescue => exception
      Trouble.notify exception
      []
    end

    def self.encoding
      'ISO-8859-1:UTF-8'  # from:to
    end

    def self.path
      ::Locality.config.postnummerfilen_path
    end

  end
end
