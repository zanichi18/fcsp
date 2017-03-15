module Education::GeneralHelper
  def load_image object
    if object.images.any?
      image_tag(object.images.first.url, class: "img wth-100")
    else
      image_tag("default", class: "img wth-100")
    end
  end
end
