require 'spec_helper'

RSpec.describe Locality::IP do

  let(:locality) { described_class.new address }
  let(:service)  { described_class.service }

  context 'nil IP' do
    let(:address) { nil }

    describe '#ip' do
      it 'does not break' do
        expect(locality.ip).to be_nil
      end
    end
  end

  context 'blank IP' do
    let(:address) { '   ' }

    describe '#ip' do
      it 'does not break' do
        expect(locality.ip).to be_nil
      end
    end
  end

  context 'IPAddr instance' do
    let(:address) { IPAddr.new('109.105.111.14') }

    describe '#human_readable_location' do
      it 'knows the country' do
        expect(locality.human_readable_location).to eq 'Sweden'
      end
    end
  end

  context 'a Swedish server' do
    let(:address)  { '109.105.111.14' }

    describe '#human_readable_location' do
      it 'knows the country' do
        expect(locality.human_readable_location).to eq 'Sweden'
      end
    end

    describe '#to_hash' do
      it 'holds all relevant information' do
        expect(locality.to_hash.keys).to eq %i(ip city_name province_name state_name country_name human_readable_location)
        expect(locality.to_hash[:country_name]).to eq 'Sweden'
        expect(locality.to_hash[:ip]).to eq '109.105.111.14'
      end
    end
  end

  context 'loopback' do
    let(:address)  { '127.0.0.1' }

    describe '#human_readable_location' do
      it 'is nil' do
        expect(locality.human_readable_location).to be_nil
      end
    end
  end

  context 'unknown country' do
    let(:address)  { '194.161.219.25' }

    describe '#human_readable_location' do
      it 'is nil' do
        expect(locality.human_readable_location).to be_nil
      end
    end
  end

  context 'custom locations' do
    context 'within range' do
      let(:address) { '198.51.100.99' }

      before do
        Locality.config.add_custom_ip_location '198.51.100.99/24', country_name: 'Land of Documentation'
      end

      describe '#human_readable_location' do
        it 'finds the custom location' do
          expect(locality.human_readable_location).to eq 'Land of Documentation'
        end
      end
    end

    context 'specific address' do
      let(:address) { '203.0.113.42' }

      before do
        Locality.config.add_custom_ip_location '203.0.113.42', city_name: 'X-Men Headquaters'
      end

      describe '#human_readable_location' do
        it 'finds the custom location' do
          expect(locality.human_readable_location).to eq 'X-Men Headquaters'
        end
      end

      describe '#to_hash' do
        it 'holds all relevant information' do
          expect(locality.to_hash.keys).to eq %i(ip city_name province_name state_name country_name human_readable_location)
          expect(locality.to_hash[:city_name]).to eq 'X-Men Headquaters'
          expect(locality.to_hash[:ip]).to eq '203.0.113.42'
        end
      end
    end
  end

end
