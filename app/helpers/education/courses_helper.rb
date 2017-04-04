module Education::CoursesHelper
  def training_select
    Education::Training.with_deleted.all.map{|training| [training.name, training.id]}
  end
end
