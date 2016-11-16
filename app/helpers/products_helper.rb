module ProductsHelper
  def render_image_by(photo, size = nil)
    if photo && photo.image.present?
      image_tag photo.image.url(size), class: "thumbnail"
    else
      case size
      when "thumb" then size = 75
      else size = 800
      end
      image_tag "http://placehold.it/#{size}x#{size}&text=No Photo", class: "thumbnail"
    end
  end
end
