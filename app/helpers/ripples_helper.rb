module RipplesHelper
  def get_ripple_tag_relationships(ripple)
    @organization.tag_relationships_for_item(ripple.item_sha256) unless ripple.item_sha256.nil?
  end
end
