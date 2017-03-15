class Education::HomeController < Education::BaseController
  def index
    @about = Education::About.first
    @projects = Education::Project.newest.includes(:images)
      .limit Settings.home.limit
    @learning_programs = Education::LearningProgram
      .limit Settings.education.index.max_learning_program
    @trainings = Education::Training.newest.includes(:techniques)
      .limit Settings.home_trainings_limit
    @courses = Education::Course.newest
      .limit Settings.courses.home_limit
  end
end
