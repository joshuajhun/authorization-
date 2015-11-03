require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "existing user can login" do
    User.create(username: "Clarence",
                password: "password")

    visit login_path
    fill_in "Username", with: "Clarence"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Welcome, Clarence!")
    assert page.has_content?("Logout")

  end

  test 'guest cannot login' do
    visit login_path
    fill_in "Username", with: "Slota_Life"
    fill_in "Password", with: "markers"
    click_button "Login"

    assert page.has_content?("Invalid Login")
    assert page.has_content?("Login")

  end

  test 'guest cannot login with inccorect password ' do
    User.create(username: "Clarence",
                password: "password")

    visit login_path
    fill_in "Username", with: "Clarence"
    fill_in "Password", with: "stuff"
    click_button "Login"

    assert page.has_content?("Invalid Login")
    assert page.has_content?("Login")

  end

  test 'authenticated user can log out' do
    User.create(username: "Clarence",
                password: "password")

    visit login_path
    fill_in "Username", with: "Clarence"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Welcome, Clarence!")

    click_link 'Logout'

    assert page.has_content?("Goodbye!")
    assert page.has_content?("Login")

  end

end
