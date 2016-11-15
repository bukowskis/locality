require 'spec_helper'

RSpec.describe Locality::Postnummerservice::ZipCode do
  describe '#code' do
    it 'harmonizes the zip codes to integers' do
      zip_code_from_int = described_class.new(12345)
      zip_code_from_string = described_class.new('12345')

      expect(zip_code_from_int.code).to eq(12345)
      expect(zip_code_from_string.code).to eq(12345)
    end
  end

  context 'with a valid zip code' do
    describe '#state' do
      it 'returns the corresponding state' do
        valid_raw_zip_code = 13153

        zip_code = described_class.new(valid_raw_zip_code)
        state = zip_code.state

        expect(state).to be_instance_of Locality::Postnummerservice::State
        expect(state.zip_codes).to include(zip_code.code)
      end
    end

    describe '#aregion' do
      it 'returns the corresponding aregion' do
        valid_raw_zip_code = 13153

        zip_code = described_class.new(valid_raw_zip_code)
        aregion = zip_code.aregion

        expect(aregion).to be_instance_of Locality::Postnummerservice::Aregion
        expect(aregion.zip_codes).to include(zip_code.code)
      end
    end
  end

  context 'with an invalid zip code' do
    describe '#state' do
      it 'returns a state with no name' do
        invalid_raw_zip_code = 99999

        zip_code = described_class.new(invalid_raw_zip_code)
        state = zip_code.state

        expect(state).to be_instance_of Locality::Postnummerservice::State
        expect(state.zip_codes).to eq([])
        expect(state.name).to be nil
      end
    end

    describe '#state' do
      it 'returns a aregion with no name' do
        invalid_raw_zip_code = 99999

        zip_code = described_class.new(invalid_raw_zip_code)
        aregion = zip_code.aregion

        expect(aregion).to be_instance_of Locality::Postnummerservice::Aregion
        expect(aregion.zip_codes).to eq([])
        expect(aregion.name).to be nil
      end
    end
  end
end
