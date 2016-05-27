require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:notch)
  end

  test "new" do
    get :new
    assert_response :success
    assert_template 'sessions/new'
    refute_nil assigns(:user)
  end

  test "create with invalid username" do
    post :create, user: { username: '', password: 'password' }
    refute flash.empty?
    assert_template :new
    refute is_signed_in?
  end

  test "create with invalid password" do
    post :create, user: { username: @user.username, password: '' }
    refute flash.empty?
    assert_template :new
    refute is_signed_in?
  end

  test "create with valid credentials" do
    post :create, user: { username: @user.username, password: 'password' }
    assert is_signed_in?
  end

  test "create with case-insensitive username" do
    sign_in_as(@user.username.swapcase)
    # do not display a "name has changed" message
    assert flash.empty?
    assert is_signed_in?
  end

  test "create with updated username" do
    outdated_username = 'asdf'
    updated_username = @user.username
    # save incorrect username to database, to simulate outdated username
    @user.update_attribute(:username, outdated_username)

    refute_nil User.find_by(username: outdated_username)
    assert_nil User.find_by(username: updated_username)

    post :create, user: { username: updated_username, password: 'password' }
    assert is_signed_in?

    assert_nil User.find_by(username: outdated_username)
    refute_nil User.find_by(username: updated_username)

    refute flash.empty?
  end

  test "create while already signed-in" do
    sign_in_as @user
    post :create, user: { username: @user.username, password: 'password' }
    assert_response 422
  end

  test "destroy" do
    sign_in_as @user
    delete :destroy
    assert_redirected_to root_url
    refute is_signed_in?
  end
end
