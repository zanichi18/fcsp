class UserSocialNetworksController < ApplicationController
  before_action :authenticate_user!

  def create
    SocialNetwork.transaction do
      social_network_params.each do |type, url|
        current_user.social_networks.create! social_network_type: type, url: url
      end
    end
    render_json t(".success"), 200, get_link_social_network
  rescue
    render_json t(".fail"), 400
  end

  def update
    SocialNetwork.transaction do
      social_network_params.each do |type, url|
        current_user.social_networks.send(type).first
          .update_attributes! social_network_type: type, url: url
      end
    end
    render_json t(".success"), 200, get_link_social_network
  rescue
    render_json t(".fail"), 400
  end

  private

  def social_network_params
    JSON.parse params.require :social_network
  end

  def render_json message, status_code, link = nil
    respond_to do |format|
      format.json do
        render json: {flash: message, status: status_code, link: link}
      end
    end
  end

  def get_link_social_network
    {facebook: current_user.link_social_network("facebook"),
    google: current_user.link_social_network("google"),
    twitter: current_user.link_social_network("twitter"),
    linkedin: current_user.link_social_network("linkedin"),
    skype: current_user.link_social_network("skype"),
    youtube: current_user.link_social_network("youtube"),
    instagram: current_user.link_social_network("instagram")}
  end
end
