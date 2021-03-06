class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_character, :current_user, :signed_in?

  def current_character
    return nil if current_user.nil?
    @current_character ||= current_user.current_character
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.where(session_token: session[:session_token]).first
  end

  def signed_in?
    !!current_user
  end

  def sign_in!(user)
    user.reset_session_token!
    @current_user = user
    session[:session_token] = user.session_token;
  end

  def sign_out!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
  end

  def must_be_signed_in
    unless signed_in?
      # TODO display flash message
      # TODO friendly forwarding
      respond_to do |format|
        format.json { render json: ["Must be signed in"], status: 401 }
        format.html { redirect_to new_session_url }
      end
    end
  end

  def must_not_be_signed_in
    if signed_in?
      render json: ["Must not be signed in"], status: 422
    end
  end

  def must_have_current_character
    unless signed_in? && current_user.current_character
      render json: ["Must have current character"], status: 403
    end
  end
end
