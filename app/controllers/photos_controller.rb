class PhotosController < ApplicationController

  before_filter :authenticate_user!

  def create
    @photo = current_user.photos.build(image: params[:photo])

    if @photo.save

      if params[:set_profile_photo]

        current_user.profile.set_photo(@photo)

        #post = Post.new(author: current_user, photos: [@photo])

        #post.save!
      end

      render layout: false, json: { success: true, data: @photo }.to_json
    else
      render nothing: true, status: 422
    end
  end

end