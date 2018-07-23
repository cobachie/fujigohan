module ApplicationHelper
  def tag_badge(tag)
    color = tag.hex || "#636e72"
    content_tag(:a, href: stands_path(tag: tag.id)) do
      content_tag(:span, class: 'stand-badge', style: "background-color: #{color}") do
        tag.name
      end
    end
  end
end
