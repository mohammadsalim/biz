class PhotosController < ApplicationController
  has_attached_file :photo
  before_action :require_current_user, only: :create

  def create
    @photo = current_user.photos.new(photo_params)

    if @photo.save
      redirect_to current_user
    else
      flash[:message] = @photo.errors.full_messages.to_sentence
      redirect_to current_user
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:photo, :description)
  end
end
