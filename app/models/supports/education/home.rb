module Supports::Education
  class Home
    attr_reader :about, :projects, :learning_programs, :trainings, :courses

    def about
      Education::About.first
    end

    def projects
      Education::Project.newest.includes(:images)
        .limit Settings.home.limit
    end

    def learning_programs
      Education::LearningProgram
        .limit Settings.education.index.max_learning_program
    end

    def trainings
      Education::Training.newest.includes(:techniques)
        .limit Settings.home_trainings_limit
    end

    def courses
      Education::Course.newest.includes(:images)
        .limit Settings.courses.home_limit
    end
  end
end
