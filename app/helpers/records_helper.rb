module RecordsHelper
  def render_record_item_link(item)
    link_to item.item_sha_256, organization_record_path(@organization, sha256: item.item_sha_256)
  end
end
