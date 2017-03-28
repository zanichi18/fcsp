module JobsHelper
  def check_apply_jobs user_id, job_id
    user = User.find_by id: user_id
    users = user.jobs.ids
    users.include?(job_id)
  end
end
