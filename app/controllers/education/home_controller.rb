class Education::HomeController < Education::BaseController
  def index
    @about = Education::About.first
    @projects = Education::Project.newest.limit(Settings.home.limit)
    @learning_programs = Education::LearningProgram
      .limit(Settings.education.index.max_learning_program)
  end
end
