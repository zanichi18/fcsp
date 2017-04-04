class Education::TrainersController < Education::BaseController
  def index
    @trainers = Education::Group.find_by(name: "Trainer").users
  end
end
