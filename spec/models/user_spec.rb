# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_or_create_from_auth_hash' do
    # it is important
    it 'does not create duplicates' do
      auth_hash = { 'uid' => '1', 'provider' => 'test' }

      described_class.find_or_create_from_auth_hash(auth_hash)
      described_class.find_or_create_from_auth_hash(auth_hash)

      expect(described_class.count).to eq(1)
    end
  end
end
