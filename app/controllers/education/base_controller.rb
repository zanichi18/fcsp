class Education::BaseController < ApplicationController
  layout "education/layouts/application"

  private

  def pagination_by_permission class_name, normal_setting, trainer_setting
    if current_user && manage?(class_name)
      trainer_setting
    else
      normal_setting
    end
  end

  def manage? object
    can?(:create, object) || can?(:update, object) || can?(:destroy, object)
  end
end
