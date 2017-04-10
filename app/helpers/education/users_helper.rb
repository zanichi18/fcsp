module Education::UsersHelper
  def get_user_education_status user
    case
    when user.education_status_active?
      content_tag :span, t("education.user_status.active"),
        class: "label label-success", id: "user-edu-status-label-#{user.id}"
    when user.education_status_blocked?
      content_tag :span, t("education.user_status.blocked"),
        class: "label label-danger", id: "user-edu-status-label-#{user.id}"
    end
  end

  def get_action_for_education_status user
    case
    when user.education_status_active?
      content_tag :button, t("education.user_status.blocked"),
        class: "btn btn-danger user_education_status",
        id: "user_education_status_#{user.id}",
        data: {id: user.id, username: user.name,
          status: Settings.education.management.users.blocked}
    when user.education_status_blocked?
      content_tag :button, t("education.user_status.active"),
        class: "btn btn-success user_education_status",
        id: "user_education_status_#{user.id}",
        data: {id: user.id, username: user.name,
          status: Settings.education.management.users.active}
    end
  end
end
