require 'csv'
require 'locality/postnummerservice/entry'

module Locality
  module Postnummerservice

    def self.aregions
      load
      @aregions
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

      entries do |entry|
        @aregions[entry.aregion] ||= []
        @aregions[entry.aregion] << entry
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
