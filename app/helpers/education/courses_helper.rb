module Education::CoursesHelper
  def training_select
    Education::Training.with_deleted.all.map{|training| [training.name, training.id]}
  end

  def check_size_max?
    training_select.size > Settings.courses.number_filter
  end
end
