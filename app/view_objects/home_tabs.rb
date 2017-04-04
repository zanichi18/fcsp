class HomeTabs < ViewObject
  def html
    safe_join tabs
  end

  private

  def tabs
    [home_tab,
     trainings_tab,
     courses_tab,
     projects_tab,
     posts_tab,
     feedbacks_tab].compact
  end

  def home_tab
    build_tab t("education.layouts.header.home"),
      education_root_path, :home
  end

  def projects_tab
    build_tab t("education.layouts.header.project"),
      education_projects_path, :projects
  end

  def posts_tab
    build_tab t("education.layouts.header.posts"),
      education_posts_path, :posts
  end

  def courses_tab
    build_tab t("education.layouts.header.courses"),
      education_courses_path, :courses
  end

  def trainings_tab
    build_tab t("education.layouts.header.trainings"),
      education_trainings_path, :trainings
  end

  def feedbacks_tab
    build_tab t("education.layouts.header.feedback"),
      new_education_feedback_path, :feedbacks
  end

  def build_tab text, path, tab_name
    content_tag :li, class: tab_class(tab_name) do
      link_to path do
        content_tag :div, text
      end
    end
  end

  def tab_class tab
    active_class = active?(tab) ? "current" : "mega-menu"
    [active_class].compact.join(" ")
  end

  def active? tab
    return true if tab.to_s == context.controller_name
    false
  end
end
