module Supports
  class ShowJob
    attr_reader :job, :company, :benefits, :members, :team_introduction,
      :hiring_types, :published_date

    delegate :benefits, :founder_on, to: :company, prefix: true

    def initialize job
      @job = job
    end

    def company
      @job.company
    end

    def members
      company.users
    end

    def jobs_company
      company.jobs.limit(4)
    end

    def company_address
      company.addresses
    end

    def team_introduction
      @job.team_introductions.includes :images
    end

    def count_candidates
      @job.candidates.count
    end

    def hiring_types
      @job.hiring_types
    end

    def job_skills
      @job.skills
    end

    def published_date
      @job.created_at.to_date
    end
  end
end
