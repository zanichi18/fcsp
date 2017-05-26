class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_certificate, only: [:edit, :destroy, :update]

  def new
    @certificate = Certificate.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @certificate = Certificate.new certificate_params
    if @certificate.save
      certificate_js t(".success"), 200
    else
      render json: {errors: @certificate.errors}
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @certificate.update_attributes certificate_params
      certificate_js t(".success"), 200
    else
      render json: {errors: @certificate.errors}
    end
  end

  def destroy
    if @certificate.destroy
      certificate_js t(".success"), 200
    else
      certificate_js t(".failed"), 400
    end
  end

  private
  def certificate_params
    params.require(:certificate).permit(:name, :qualified_time,
      :qualified_organization).merge! user: current_user
  end

  def certificate_js message, status
    @status = status
    @message = message
    respond_to do |format|
      format.js
    end
  end

  def load_certificate
    return if @certificate = current_user.certificates.find_by(id: params[:id])
    flash[:error] = t ".not_found"
    redirect_to user_path current_user
  end
end
