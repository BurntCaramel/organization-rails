module TextsHelper
  include S3Helper

  def render_item_link(item)
    link_to item.item_sha_256, organization_text_path(@organization, sha256: item.item_sha_256)
  end

  def render_item_text(item)
    get_item_text item.item_sha_256
  end

  def get_item_tag_relationships(item)
    @organization.tag_relationships_for_item(item.item_sha_256)
  end
end
