module ImagesHelper
  IMAGE_MAX_WIDTH = 200

  def render_image(sha256, width)
    url1x = @imgix.path("/#{ sha256 }").to_url(w: width, fit: 'max', auto: 'format')
    url2x = @imgix.path("/#{ sha256 }").to_url(w: width, fit: 'max', dpr: 2, auto: 'format')
    srcset = [
      "#{ url1x } 1x",
      "#{ url2x } 2x"
    ].join(', ')
    image_tag(url1x, srcset: srcset)
  end

  def render_image_item_link(item, options = {})
    max_width = options[:max_width] || IMAGE_MAX_WIDTH
    link_to render_image(item.item_sha_256, max_width), organization_image_path(@organization, sha256: item.item_sha_256)
  end

  def get_item_tag_relationships(item)
    @organization.tag_relationships_for_item(item.item_sha_256)
  end
end
