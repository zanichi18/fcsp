class Education::CoursesController < Education::BaseController
  def index
    @courses = Education::Course.newest.page(params[:page])
      .per Settings.courses.index_limit
  end
end
