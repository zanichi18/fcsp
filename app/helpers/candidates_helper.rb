module CandidatesHelper
  def check_apply_jobs? user_id, job_id
    Candidate.find_by user_id: user_id, job_id: job_id
  end
end
