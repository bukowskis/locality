require 'spec_helper'

RSpec.describe Locality::Postnummerservice::State do

  let(:state) { described_class.new code }

  describe '.codes' do
    it 'has all codes' do
      expect(described_class.codes).to eq 1 => 'Stockholm', 9 => 'Gotland'
    end
  end

  context 'unknown code' do
    let(:code) { '999999999' }

    describe '#zip_codes' do
      it 'does not break' do
        expect(state.zip_codes).to be_empty
      end
    end
  end

  context 'Stockholms län' do
    let(:code) { 1 }

    describe '#zip_codes' do
      it 'knows the zip codes, without duplicates' do
        expect(state.zip_codes).to eq %w(13055 13056 13061 13100 13102 13104 13105 13106 13107 13108 13110 13120 13121 13122 13123 13124 13125 13126 13127 13128 13129 13130 13131 13132 13133 13134 13135 13136 13137 13138 13139 13140 13141 13142 13143 13144 13145 13146 13147 13148 13149 13150 13152 13153 13154 13155 13156 13159 13160).map(&:to_i)
      end
    end

    describe '#name' do
      it 'knows its own name' do
        expect(state.name).to eq 'Stockholm'
      end
    end

    describe '#city_names' do
      it 'knows the city names' do
        expect(state.city_names).to eq %w(Hårsfjärden Nacka Nacka\ Strand Ornö Saltsjö-Duvnäs Stockholm Utö)
      end
    end

    describe '#aregion_codes' do
      it 'knows the aregion codes' do
        expect(state.aregion_codes).to eq [1]
      end
    end

    describe '#province_codes' do
      it 'knows the province codes' do
        expect(state.province_codes).to eq %w(0136 0180 0182)
      end
    end

    describe '#province_names' do
      it 'knows the province names' do
        expect(state.province_names).to eq %w(Haninge Nacka Stockholm)
      end
    end
  end

end