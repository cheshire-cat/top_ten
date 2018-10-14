# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopTenTableBuilder, type: :model do
  subject(:builder) { described_class.new }

  describe '#create_from_top_ten_resp!' do
    context 'when valid JSON String with data' do
      let(:top_ten_resp) { File.read('spec/support/top_ten.json') }

      it 'builds expected table' do
        actual = builder.create_from_top_ten_resp!(top_ten_resp)

        expected = [
          ['BTC', 'Bitcoin', 111774707273.6615, 6493.02288075],
          ['ETH', 'Ethereum', 30511368440.317066, 300.96820061],
          ['XRP', 'XRP', 12314075039.39252, 0.31275906996],
          ['BCH', 'Bitcoin Cash', 9281794749.030472, 536.603675084],
          ['EOS', 'EOS', 4372521683.936184, 4.82487750722],
          ['XLM', 'Stellar', 4212724903.4312243, 0.224418289623],
          ['LTC', 'Litecoin', 3299617525.0965114, 57.0076254859],
          ['USDT', 'Tether', 2682688096.4675455, 1.00207227121],
          ['ADA', 'Cardano', 2575851346.823693, 0.0993498800047],
          ['XMR', 'Monero', 1571739403.3761733, 96.280466296]
        ]

        expect(actual).to eq(expected)
      end
    end

    context 'when valid JSON String with error' do
      let(:top_ten_resp) { File.read('spec/support/top_ten_error.json') }

      it 'raises error' do
        expect { builder.create_from_top_ten_resp!(top_ten_resp) }.
          to raise_error(TopTenTableBuilder::ResponseError)
      end
    end

    context 'when receives not String' do
      it 'raises error' do
        expect { builder.create_from_top_ten_resp!(nil) }.
          to raise_error(TypeError)
      end
    end

    context 'when receives not a JSON String' do
      it 'raises error' do
        expect { builder.create_from_top_ten_resp!('asdf') }.
          to raise_error(JSON::ParserError)
      end
    end
  end
end
