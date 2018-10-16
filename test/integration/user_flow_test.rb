require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  test "Guest will land on sign up page" do
    logout(:user)
    visit "/"
    assert_text "Sign Up"
  end
  
  test "Users will land on connected page" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user, run_callbacks: false)
    visit "/"
    assert_text "Connected"
  end
  
  test "Sign up" do
    new_user_email = "new.user@solfanto.com"
    new_user_password = "cccccc"
    
    logout(:user)
    
    visit "/"
    
    within ".new_user" do
      fill_in :user_email, with: new_user_email
      fill_in :user_password, with: new_user_password
      fill_in :user_password_confirmation, with: new_user_password
      click_on "Sign Up"
    end
    
    user = User.last
    assert user&.email == new_user_email, "Email (#{user&.email}) doesn't match with #{new_user_email}"
    assert user&.admin == false, "User shouldn't be admin"
  end
  
  test "Log in" do
    user = FactoryBot.create(:user)
    logout(:user)
    
    visit "/"
    
    within ".navbar" do
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password
      click_on "Log In"
    end
    
    assert_text "Connected"
    
    within ".navbar" do
      assert_text user.email
    end
  end
  
  test "Log in with wrong password" do
    user = FactoryBot.create(:user)
    wrong_password = "wrong_password"
    logout(:user)
    
    visit "/"
    
    within ".navbar" do
      fill_in :user_email, with: user.email
      fill_in :user_password, with: wrong_password
      click_on "Log In"
    end
    
    assert_text "Invalid Email or password."
    
    within ".navbar" do
      assert_no_text user.email
    end
  end
end
