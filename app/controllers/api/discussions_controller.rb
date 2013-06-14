class Api::DiscussionsController < ApiController

  # GET /api/discussions
  def index
    @discussions = current_user.discussions

    respond_with @discussions, api_template: :angular
  end

  # POST /api/discussions
  def create

    params[:discussion]['messages_attributes'].map do |m|
      m.merge(user: current_user)
    end

    params[:discussion][:speakers_attributes] = []

    params[:discussion]['recipient_ids'].each do |r|
      params[:discussion][:speakers_attributes] << { :user => User.find(r) }
    end

    params[:discussion][:speakers_attributes] << { :user => current_user }

    params[:discussion] = params[:discussion].except('recipient_ids')

    @discussion = Discussion.new(params[:discussion])

    dialog = nil

    if params[:discussion][:speakers_attributes].size == 2
      dialog = Discussion.find_between_users(current_user, params[:discussion][:speakers_attributes][:user].id)

      if dialog
        params[:discussion]['messages_attributes'].each do |m|
          Message.create(discussion: dialog, user: current_user, body: m.body) if m.body
        end

        respond_with dialog, api_template: :angular, location: nil
      end
    end

    unless dialog

      if @discussion.save
        respond_with @discussion, api_template: :angular, location: nil
      else
        render nothing: true, status: :unprocessable_entity
      end
    end


  end

end
