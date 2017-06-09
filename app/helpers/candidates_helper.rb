module CandidatesHelper
  def check_apply_jobs? user_id, job_id
    Candidate.find_by user_id: user_id, job_id: job_id
  end

  def load_avatar_candidate candidate
    avatar = candidate.avatar.present? ? candidate.avatar : PictureUploader.new
    image_tag avatar.picture_url,
      size: Settings.employer.candidates.avatar_size, class: "media-photo"
  end
end
