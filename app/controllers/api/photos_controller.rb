class Api::PhotosController < ApiController

  # todo: заменить carrierwave на paperclip
  def create
    @photo = current_user.photos.build(image: params[:photo])

    if @photo.save

      if params[:set_profile_photo]

        current_user.profile.set_photo(@photo)

        #post = Post.new(author: current_user, photos: [@photo])

        #post.save!
      end

      respond_with @photo, api_template: :angular, location: api_photo_url(@photo)
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def show
    @photo = Photo.find(params[:id])

    respond_with @photo, api_template: :angular, location: api_photo_url(@photo)
  end

end
