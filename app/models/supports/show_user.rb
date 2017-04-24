module Supports
  class ShowUser
    attr_reader :job_active, :job_skill, :portfolios

    def initialize user
      @user = user
    end

    def job_active
      Job.active.includes :images, :skills, :job_skills
    end

    def job_skill
      ArrayJob.get_job job_active, @user
    end

    def portfolios
      @user.user_portfolios.includes(:images).order created_at: :DESC
    end
  end
end
