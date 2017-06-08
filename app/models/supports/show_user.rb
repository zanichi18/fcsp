module Supports
  class ShowUser
    attr_reader :job_active, :job_skill, :portfolios, :awards,
      :shared_job_ids, :list_friends

    def initialize user, current_user, params
      @user = user
      @current_user = current_user
      @params = params
    end

    def job_active
      Job.active.includes :company, :images, :skills, :job_skills
    end

    def job_skill
      ArrayJob.get_job job_active, @user
    end

    def portfolios
      @user.user_portfolios.includes(:images).order created_at: :DESC
    end

    def awards
      @user.awards.order created_at: :DESC
    end

    def shared_job_ids
      @current_user.friends.pluck(:id) << @current_user.id
    end

    def shared_jobs
      ShareJob.shared_jobs(shared_job_ids).includes :job, user: :avatar
    end

    def list_friends
      @user.friends.search(name_cont: @params[:friend_search]).result
        .includes :avatar
    end

    def user_jobs
      if @user.is_user? @current_user
        Kaminari.paginate_array(job_skill).page(@params[:suggest_jobs_page])
          .per Settings.user.per_page
      end
    end

    def bookmarked_jobs
      if @user.is_user? @current_user
        @current_user.bookmarked_jobs.page(@params[:bookmarked_jobs_page])
          .per Settings.user.per_page
      end
    end

    def list_post
      @user.posts.newest.page(@params[:user_post_page])
        .per Settings.post.per_page
    end
  end
end
