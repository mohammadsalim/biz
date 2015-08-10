class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])

    if @user.authenticate(user_params[:password])
      login!(@user)
      redirect_to user_path(@user.id)
    else
      flash[:message] = "User email or Password error"
    end
  end

  def destroy
    logout!
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
