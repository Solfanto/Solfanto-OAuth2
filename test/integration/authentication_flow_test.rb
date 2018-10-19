require 'test_helper'

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  test "User authenticates for the first time" do
    
    # Ask Authorization code for app
    user = FactoryBot.create(:user)
    login_as(user, scope: :user, run_callbacks: false)

    application = FactoryBot.create(:application)

    state = "96ae13b852e183d024976a1b5507d03d443a4291eb625ec9"

    visit oauth_authorization_path( client_id: application.uid, redirect_uri: application.redirect_uri, response_type: "code", state: state )
    
    click_on "Authorize"
    
    response = JSON.parse(page.body)
    assert_equal state, response['state']
    code = response['code']
    
    # Ask new token
    post "/oauth/token", params: { client_id: application.uid, client_secret: application.secret, code: code, grant_type: "authorization_code", redirect_uri: "#{application.redirect_uri}?code=#{code}&state=#{state}" }
    
    response = JSON.parse(@response.body)
    assert_equal "Bearer", response['token_type']
    access_token = response['access_token']
    
    # Request user info
    get "/oauth/token/info/me.json", headers: { 'HTTP_AUTHORIZATION' => "Bearer #{access_token}"}

    response = JSON.parse(@response.body)
    assert_no_match /invalid_token/, @response.headers["WWW-Authenticate"]
    assert_equal user.id, response['uid']
    assert_equal user.email, response['email']
  end
end
