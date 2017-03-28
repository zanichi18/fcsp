class Education::UsersController < Education::BaseController
  load_resource

  def show
    @show_user_object = Supports::Education::ShowUser.new @user, params[:page]
    @activities = Activity.load_by_current_user(current_user).recent
      .pagination params[:page]
  end
end
