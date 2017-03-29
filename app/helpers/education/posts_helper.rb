require "redcarpet"

module Education::PostsHelper
  include ActsAsTaggableOn::TagsHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code code, language
      Pygments.highlight(code, lexer: language)
    end
  end
  def markdown_render content
    renderer = HTMLwithPygments.new hard_wrap: true, filter_html: true,
      tables: true
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      quote: true,
      highlight: true,
      tables: true,
      emoji: true
    }

    Redcarpet::Markdown.new(renderer, options).render(content)
  end

  def category_select
    Education::Category.all.map{|category| [category.name, category.id]}
  end

  def load_cover_photo post
    if post.cover_photo.present?
      image_tag post.cover_photo, alt: post.title
    else
      image_tag "default", alt: post.title
    end
  end
end
