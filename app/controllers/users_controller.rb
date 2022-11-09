class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = current_user
  end

  def sign_out
    sign_out_and_redirect(current_user)
  end
end
