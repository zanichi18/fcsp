require "redcarpet"

module Education::PostsHelper
  def markdown_render content
    markdown = Redcarpet::Markdown
      .new Redcarpet::Render::HTML, autolink: true, tables: true
    markdown.render content
  end

  def category_select
    Education::Category.all.map{|category| [category.name, category.id]}
  end

  def load_cover_photo post
    if post.cover_photo.present?
      image_tag post.cover_photo.url, alt: post.title
    else
      image_tag "default", alt: post.title
    end
  end
end
