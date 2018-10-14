# frozen_string_literal: true

module NumberToUsdHelper
  # @see ActionView::Helpers::NumberHelper#number_to_currency
  def number_to_usd(number)
    number_to_currency(number,
      unit: '$',
      separator: '.',
      delimiter: ','
    )
  end
end
