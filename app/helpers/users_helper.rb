module UsersHelper
  def load_user_avatar user, class_custom = nil
    if user.avatar.present?
      image_tag user.avatar.picture, alt: user.name.to_s,
        class: class_custom.to_s
    else
      image_tag "avatar.jpg", alt: user.name.to_s,
        class: class_custom.to_s
    end
  end

  def load_user_cover user, class_custom
    if user.cover_image.present?
      image_tag user.cover_image.picture, alt: user.name.to_s,
        class: class_custom.to_s
    else
      image_tag "cover_image_default.jpg", alt: user.name.to_s,
        class: class_custom.to_s
    end
  end
end
