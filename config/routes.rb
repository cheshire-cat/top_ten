# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'
  get '/top_ten', to: 'pages#top_ten'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure' => redirect('/')
  delete '/logout', to: 'sessions#destroy'
end
