module JobsHelper
  def select_hiring_type
    HiringType.all.map{|key| [key.name, key.id]}
  end

  def shared_job? job
    @shared_job_ids.include? job.id if @shared_job_ids.present?
  end
end
