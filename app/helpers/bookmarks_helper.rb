module BookmarksHelper
  def bookmarked? user, job
    user.bookmarks.find_by job_id: job.id
  end
end
