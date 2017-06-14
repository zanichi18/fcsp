class Api::TmsDataService
  def initialize current_user, user_token
    @url = Settings.api.tms_data_link
    @current_user = current_user
    @auth_token = user_token
  end

  def synchronize_tms_data
    params = {email: @current_user.email}
    http_request = Api::HttpActionService.new @url, params, @auth_token
    response = http_request.get_data
    if response && response.code.to_i == 200
      return synchronize_data JSON.parse response.body
    end
    false
  end

  def tms_user_exist?
    params = {email: @current_user.email}
    http_request = Api::HttpActionService.new @url, params, @auth_token
    response = http_request.get_data
    response && response.code.to_i == 404 ? false : true
  end

  private

  def synchronize_user_education response_json
    data_user = response_json["data"]["user"]
    school = School.find_or_create_by name: data_user["profile"]["university"]
    user_education = UserEducation.find_or_create_by school_id: school.id,
      user_id: @current_user.id
    user_education.update graduation: data_user["profile"]["graduation"]
  end

  def synchronize_user_skill response_json
    response_json["data"]["user"]["courses"].each do |course|
      skills = course["subjects"]
      update_user_skill_data skills
    end
  end

  def update_user_skill_data skills
    skills.each do |skill_json|
      skill = Skill.find_or_create_by name: skill_json["subject_name"]
      SkillUser.find_or_create_by skill_id: skill.id,
        user_id: @current_user.id
    end
  end

  def synchronize_data response_json
    begin
      ActiveRecord::Base.transaction do
        synchronize_user_education response_json
        synchronize_user_skill response_json
      end
    rescue StandardError
      return false
    end
    true
  end
end
