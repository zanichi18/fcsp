module JobsHelper
  def select_hiring_type
    HiringType.all.map{|key| [key.name, key.id]}
  end

  def shared_job? job
    @shared_job_ids.include? job.id if @shared_job_ids.present?
  end

  def load_image_job job
    if job.images.present?
      image_tag job.images.first.picture
    else
      image_tag PictureUploader.new.picture_url
    end
  end
end
