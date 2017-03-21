class Education::UsersController < Education::BaseController
  load_resource

  def show
    @show_user_object = Supports::Education::ShowUser.new @user, params[:page]
  end
end
