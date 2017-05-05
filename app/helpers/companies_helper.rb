module CompaniesHelper
  def load_companies_avatar companies, options = {}
    if companies.avatar.present?
      image_tag companies.avatar.picture,
        class: options[:class].to_s
    else
      image_tag Settings.company.avatar_default,
        class: options[:class].to_s
    end
  end

  def load_companies_cover companies, options = {}
    if companies.cover_image.present?
      image_tag companies.cover_image.picture,
        class: options[:class].to_s
    else
      image_tag Settings.company.cover_default,
        class: options[:class].to_s
    end
  end
end
