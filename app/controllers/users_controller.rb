class UsersController < ApplicationController
  before_action :fetch_user, only: :show

  def show
    respond_to do |format|
      format.html
      # look up JSON Builder
      format.json { render json: @user.to_json(include: :posts) }
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to @user
      # redirect_to user_path(@user.id)
    else
      flash[:message] = @user.errors
                             .full_messages
                             .to_sentence

      redirect_to new_user_path
    end
  end

  private

  def fetch_user
    @user = User.includes(:posts).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
