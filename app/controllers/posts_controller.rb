class PostsController < ApplicationController
  before_action :require_current_user, only: :create

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to current_user
    else
      flash[:message] = @post.errors.full_messages.to_sentence
      redirect_to current_user
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
