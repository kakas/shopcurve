module ApplicationHelper

  def render_icon(font)
    content_tag :i, "", class: "material-icons #{font}"
  end


  def enum_option_pairs(model, enum_name)
    plural_enum_name = enum_name.to_s.pluralize
    model.send(plural_enum_name).map do |enum_key, enum_value|
      translated_key = t("#{model.to_s.downcase}.enums.#{enum_name}.#{enum_key}")
      [translated_key, enum_key]
    end
  end

  def popup_flash_message
    flash_messages = []
    flash.each do |type, msg|
      text = "<script>toastr.#{type}('#{msg}');</script>"
      flash_messages << text.html_safe if type && msg
    end
    flash_messages.join("\n").html_safe
  end

end
