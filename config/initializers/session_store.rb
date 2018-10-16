# frozen_string_literal: true

App::Application.config.session_store :redis_store,
  # not a secure setup... just for demonstration
  servers: ["redis://redis:6379/0/#{ENV['RAILS_ENV']}:sessions"],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.parent_name.downcase}_session"
