# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoinMarket, type: :model do
  # Innacurate. Just to make sure it works.
  describe '#top_ten' do
    it 'returns String' do
      stub_request(:get, %r{api.coinmarketcap.com}).
        to_return(status: 200, body: File.read('spec/support/top_ten.json'))

      expect(described_class.new.top_ten).to be_kind_of(String)
    end
  end
end
