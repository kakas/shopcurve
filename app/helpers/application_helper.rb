module ApplicationHelper

  def render_icon(font)
    content_tag :i, "", class: "material-icons #{font}"
  end

end
