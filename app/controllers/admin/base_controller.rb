class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout "admin/layouts/admin"
end
