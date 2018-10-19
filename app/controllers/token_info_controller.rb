# frozen_string_literal: true

class TokenInfoController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json
  
  def me
    if doorkeeper_token && doorkeeper_token.accessible?
      me = User.find(doorkeeper_token.resource_owner_id)
      render json: doorkeeper_token.as_json.merge(uid: me.id.to_s, email: me.email), status: :ok
    else
      error = OAuth::ErrorResponse.new(name: :invalid_request)
      response.headers.merge!(error.headers)
      render json: error.body, status: error.status
    end
  end
end
