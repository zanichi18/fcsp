class Education::TrainersController < Education::BaseController
  def index
    @trainers = Education::Group.get_trainers.users.includes :info_user
  end
end
