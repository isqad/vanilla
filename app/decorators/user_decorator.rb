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

    if context[:current_user].present? && object.id != context[:current_user].id
      friendship = context[:current_user].friendships.find_by_friend_id(object)
      if friendship.nil?
        inverse_friendship = object.friendships.find_by_friend_id(context[:current_user])
        friendship = inverse_friendship if inverse_friendship.present? && !inverse_friendship.pending?
      end
    end

    attrs = object.as_api_response(:user).merge({
      :friendship_status => friendship.present? ? friendship.state : nil,
      :inverse_friendship_status => inverse_friendship.present? ? inverse_friendship.state : nil,
      :friendship_id => friendship.present? ? friendship.id : inverse_friendship.present? ? inverse_friendship.id : nil
    })

    attrs
  end

end
