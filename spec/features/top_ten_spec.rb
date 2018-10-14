# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Top Ten', type: :feature do
  scenario 'check table' do
    stub_request(:get, %r{api.coinmarketcap.com}).
      to_return(status: 200, body: File.read('spec/support/top_ten.json'))

    visit '/top_ten'

    expect(page).to have_content('Bitcoin')
  end
end
