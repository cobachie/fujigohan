module ApplicationHelper
  def tag_badge(tag)
    style = "background-color: #{tag.hex || '#3c6382'};"
    params_tag_ids = request.query_parameters["tag"].dup || []
    params_tag_ids << tag.id.to_s
    params_tag_ids.uniq!
    url = URI(stands_path)
    url.query = {tag: params_tag_ids}.to_query
    content_tag(:a, href: url.to_s) do
      content_tag(:span, class: 'stand-badge', style: style) do
        tag.name
      end
    end
  end
end
