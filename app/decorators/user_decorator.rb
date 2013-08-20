class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def as_json(options = {})

    friendship = object.friendships.find_by_friend_id(context[:current_user]) if context[:current_user].present? && object.id == context[:current_user].id

    attrs = object.as_api_response(:user).merge({
      :friendship_status => friendship.present? ? friendship.current_state : nil
    })

    attrs
  end

end
