class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth

    if @user.persisted?
      if is_navigational_format?
        set_flash_message :notice, :success, kind: auth.provider
      end
      sign_in_and_redirect @user
    else
      flash[:notice] = t ".auth_failure"
      redirect_to root_path
    end
  end

  def failure
    flash[:notice] = t ".auth_failure"
    redirect_to root_path
  end

  alias hr_system create
end
