class Education::BaseController < ApplicationController
  layout :render_layout

  def render_layout
    if current_user
      "education/layouts/application_trainer"
    else
      "education/layouts/application"
    end
  end
end
