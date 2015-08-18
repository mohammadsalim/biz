class StaticPagesController < ApplicationController
  def home
    @post = current_user.posts.build if current_user
  end

  def about
  end
end
