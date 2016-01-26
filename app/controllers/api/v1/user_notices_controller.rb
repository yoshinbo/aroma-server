class Api::V1::UserNoticesController < Api::ApplicationController
  def index
    @user_notices = UserNotice.fetch_related(current_user.id)
  end
end
