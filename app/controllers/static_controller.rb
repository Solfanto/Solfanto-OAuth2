class StaticController < ApplicationController
  def index
    if current_user
      render :index
    else
      render 'devise/registrations/new'
    end
  end

  def letsencrypt
    if params[:id] == Rails.application.credentials[Rails.env.to_sym][:letsencrypt_acme_challenge]
      render plain: params[:id] + "." + Rails.application.credentials[Rails.env.to_sym][:letsencrypt_acme_challenge_secret]
    else
      render plain: nil
    end
  end
  
  def test_mockup_callback
    if Rails.env.test?
      render json: params
    else
      render json: {}
    end
  end
end