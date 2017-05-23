module TeamsHelper
  def load_team_image team, options = {}
    if team.images.present?
      if team.images.first.picture.present?
        image_tag team.images.first.picture,
          class: options[:class].to_s
      else
        image_tag "avatar.jpg",
          class: options[:class].to_s
      end
    else
      image_tag "avatar.jpg",
        class: options[:class].to_s
    end
  end
end
