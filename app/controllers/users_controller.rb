class UsersController < ApplicationController
  before_action :fetch_user, only: :show

  def show
    respond_to do |format|
      format.html
      format.json { render json: @user.to_json(include: :posts) }
      format.json { render json: @user.to_json(include: :photos) }
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
    @user = User.includes(:photos).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
