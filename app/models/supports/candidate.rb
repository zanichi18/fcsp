module Supports
  class Candidate
    attr_reader :company, :job_ids

    def initialize company, job_ids
      @company = company
      @job_ids = job_ids
    end

    def candidates
      @company.candidates.includes(:user, :job).in_job(job_ids)
    end
  end
end
