class Employer::BaseController < ApplicationController
  layout "employer/layouts/application"
  load_resource :company
end
