module ProductsHelper
  def render_image_by(product, size = nil)
    if product.image&.url
      image_tag product.image.url(size), class: "thumbnail"
    else
      case size
      when "thumb" then size = "75x75"
      when "medium" then size = "500x455"
      else size = "1920x790"
      end
      image_tag "http://placehold.it/#{size}&text=No Photo", class: "thumbnail"
    end
  end
end
