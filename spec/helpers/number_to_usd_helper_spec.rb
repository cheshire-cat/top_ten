# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NumberToUsdHelper, type: :helper do
  # skip other test, because it completely relies on
  # ActionView::Helpers::NumberHelper#number_to_currency
  context 'when number given' do
    let(:number) { 1571739403.3761733 }

    it 'formats to USD currency' do
      actual = helper.number_to_usd(number)

      expected = '$1,571,739,403.38'

      expect(actual).to eq(expected)
    end
  end
end
