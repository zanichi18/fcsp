module CandidatesHelper
  def check_apply_jobs? user_id, job_id
    Candidate.find_by user_id: user_id, job_id: job_id
  end

  def load_avatar_candidate candidate
    if candidate.avatar.present?
      img = candidate.avatar.picture
    else
      img = PictureUploader.new.picture_url
    end
    image_tag img,
      size: Settings.employer.candidates.avatar_size, class: "media-photo"
  end
end
