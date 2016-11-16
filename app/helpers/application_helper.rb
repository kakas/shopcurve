module ApplicationHelper

  def icon(font)
    content_tag :i, "", class: "material-icons #{font}"
  end

end
