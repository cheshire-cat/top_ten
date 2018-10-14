# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    begin
      @user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = 'Welcome!'
    rescue
      flash[:warning] = 'Error!'
    end

    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end

    redirect_to root_path
  end
end
