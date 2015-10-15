class UsersController < ApplicationController
  include Verifiable

  before_action :must_not_be_signed_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    # TODO this doesn't need to use @verified_params, because attributes are verified on the User model, before valiation
    @user = User.new(@verified_params)
    if @user.save
      # TODO display activation instructions
      # sign_in!(@user)
      # redirect_to @user
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
