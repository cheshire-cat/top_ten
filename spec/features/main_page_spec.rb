# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Main Page', type: :feature do
  scenario 'it works' do
    visit root_path

    expect(page).to have_content 'TopTen'
  end
end
