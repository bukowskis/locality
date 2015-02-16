require 'spec_helper'

RSpec.describe Locality::Postnummerservice::Province do

  let(:province) { described_class.new code }

  describe '.codes' do
    it 'has all codes' do
      expect(described_class.codes).to eq '0136' => 'Haninge', '0182' => 'Nacka', '0180' => 'Stockholm', '0980' => 'Gotland', '2482' => 'Skellefteå'
    end
  end

  context 'Nacka Kommun' do
    let(:code) { '0182' }

    describe '#zip_codes' do
      it 'knows the zip codes, without duplicates' do
        expect(province.zip_codes).to eq %w(13100, 13102, 13104, 13105, 13106, 13107, 13108, 13110, 13120, 13121, 13122, 13123, 13124, 13125, 13126, 13127, 13128, 13129, 13130, 13131, 13132, 13133, 13134, 13135, 13136, 13137, 13138, 13139, 13140, 13141, 13142, 13143, 13144, 13145, 13146, 13147, 13148, 13149, 13150, 13152, 13153, 13154, 13155, 13156, 13159, 13160).map(&:to_i)
      end
    end

    describe '#name' do
      it 'knows its own name' do
        expect(province.name).to eq 'Nacka'
      end
    end

    describe '#city_names' do
      it 'knows the city names' do
        expect(province.city_names).to eq %w(Nacka Nacka\ Strand Saltsjö-Duvnäs Stockholm)
      end
    end

    describe '#aregion_codes' do
      it 'knows the aregion codes' do
        expect(province.aregion_codes).to eq [1]
      end
    end
  end

end