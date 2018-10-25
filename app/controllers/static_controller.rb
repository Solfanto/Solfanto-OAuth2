class StaticController < ApplicationController
  def index
    if current_user
      render :index
    else
      render 'devise/registrations/new'
    end
  end

  def letsencrypt
    if Rails.application.credentials[Rails.env.to_sym][:letsencrypt_acme_challenge].keys.map(&:to_s).include?(params[:id])
      render plain: params[:id] + "." + Rails.application.credentials[Rails.env.to_sym][:letsencrypt_acme_challenge][params[:id].to_sym]
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
