class UsersController < ApplicationController
  def new; end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      redirect_to root_path
    else
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:alias, :bio, :email, :password, :password_confirmation)
  end
end
