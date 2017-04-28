module Supports
  class Candidate
    attr_reader :company, :job_ids

    def initialize company, job_ids
      @company = company
      @job_ids = job_ids
    end

    def candidates
      @company.candidates.includes(:user, :avatar, :job).in_jobs(job_ids)
    end

    def active_jobs
      @company.jobs.active.newest
    end

    def filter_candidates list_filter, sort_by, type
      @company.candidates.includes(:user, :avatar, :job).in_jobs(job_ids)
        .filter(list_filter, sort_by, type)
    end
  end
end
