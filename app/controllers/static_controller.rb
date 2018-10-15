class StaticController < ApplicationController
  def index
    if current_user
      render :index
    else
      render 'devise/registrations/new'
    end
  end
end