class Api::SearchController < ApiController

  def show
    query = params[:q].strip

    @users = User.joins{profile}
                 .where('"users"."id" <> ?', current_user.id)
                 .where{(username =~ "%#{query}%") |
                        (profile.first_name =~ "%#{query}%") |
                        (profile.last_name =~ "%#{query}%")}

    respond_with @users, :api_template => :user
  end

end
