class Education::Management::PermissionsController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::Permission

  def create
    permissions_params.each do |id, value|
      permission = find_permission id
      unless permission
        render_json t(".not_found"), 400
        break
      end
      if permission.update_attributes optional: value.symbolize_keys
        render_json t(".success"), 200
      else
        render_json t(".fail"), 400
        break
      end
    end
  end

  private

  def permissions_params
    JSON.parse params.require :permissions
  end

  def find_permission id
    Education::Permission.find_by id: id
  end

  def render_json message, status_code
    respond_to do |format|
      format.json{render json: {flash: message, status: status_code}}
    end
  end
end
