# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'TopTen', type: :feature do
  scenario 'redirects to main page when not authenticated' do
    visit top_ten_path

    expect(page).to have_current_path(root_path)
  end

  scenario 'log in, check table, log out' do
    stub_request(:get, %r{api.coinmarketcap.com}).
      to_return(status: 200, body: File.read('spec/support/top_ten.json'))

    visit root_path

    click_link 'Log In with GitHub'

    click_link 'Top Ten Table'

    expect(page).to have_content('Bitcoin')

    click_link 'Log Out'

    expect(page).to_not have_content('Bitcoin')
    expect(page).to have_current_path(root_path)
  end

  scenario 'authentication fails' do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    stub_request(:get, %r{api.coinmarketcap.com}).
      to_return(status: 200, body: File.read('spec/support/top_ten.json'))

    visit root_path

    click_link 'Log In with GitHub'

    visit top_ten_path

    expect(page).to_not have_content('Bitcoin')
    expect(page).to have_current_path(root_path)

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      'provider' => 'github',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser'
      }
    )
  end

  scenario 'coinmarket fails' do
    stub_request(:get, %r{api.coinmarketcap.com}).
      to_return(status: 200, body: File.read('spec/support/top_ten_error.json'))

    visit root_path

    click_link 'Log In with GitHub'

    # Not production ENV. It raises errors rather that shows them.
    expect { click_link 'Top Ten Table' }.
      to raise_error(TopTenTableBuilder::ResponseError)

    click_link 'Log Out'
  end
end
