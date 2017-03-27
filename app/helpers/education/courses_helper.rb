module Education::CoursesHelper
  def training_select
    Education::Training.all.map{|training| [training.name, training.id]}
  end
end
