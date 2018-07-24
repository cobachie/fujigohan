module ApplicationHelper
  def tag_badge(tag)
    style = "background-color: #{tag.hex || '#3c6382'};"
    content_tag(:a, href: stands_path(tag: tag.id)) do
      content_tag(:span, class: 'stand-badge', style: style) do
        tag.name
      end
    end
  end
end
