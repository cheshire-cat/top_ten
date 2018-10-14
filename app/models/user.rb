# frozen_string_literal: true

class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by(uid: auth_hash.fetch('uid'),
                      provider: auth_hash.fetch('provider'))
  end
end
