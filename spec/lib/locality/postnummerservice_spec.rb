require 'spec_helper'

RSpec.describe Locality::Postnummerservice do

  let(:service) { described_class }

  describe '.aregions' do
    it 'knows all aregions' do
      expect(service.aregions.keys).to eq [1,21]
    end

    it 'knows all zip codes of one aregion' do
      expect(service.aregions[1].map(&:zip_code)).to eq %w(13055 13056 13061 13100 13102 13104 13105 13106 13107 13108 13110 13120 13121 13122 13123 13124 13125 13126 13127 13128 13129 13130 13131 13132 13133 13134 13135 13136 13137 13138 13139 13140 13141 13142 13143 13144 13145 13146 13147 13148 13149 13150 13152 13153 13154 13155 13155 13156 13159 13160)
    end
  end

end
