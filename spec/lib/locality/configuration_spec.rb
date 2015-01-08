require 'spec_helper'

RSpec.describe Locality::Configuration do

  let(:config) { described_class.new }

  describe '#maxmind_geoip2_paths' do
    let(:paths) { config.maxmind_geoip2_paths.map(&:to_s) }

    it 'includes the relative db path' do
      expect(paths).to include "#{Dir.pwd}/db/GeoLite2-City.mmdb"
    end

    it 'includes the /mnt/databases path' do
      expect(paths).to include '/mnt/data/maxmind/GeoLite2-City.mmdb'
    end

    it 'includes a custom path' do
      config.maxmind_geoip2_path = '/tmp/totally_custom/geo.mmdb'
      expect(paths).to include '/tmp/totally_custom/geo.mmdb'
    end
  end

end
