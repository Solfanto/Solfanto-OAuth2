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
      render text: params[:id] + "." + Rails.application.credentials[Rails.env.to_sym][:letsencrypt_acme_challenge_secret] and return
    else
      render text: nil and return
    end
  end
end