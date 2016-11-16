class Item
  include ActiveModel::Model

  attr_accessor :organization_id, :tag_id, :sha256

  def self.from_tag_relationship(item_relationship)
    self.new(
      organization_id: item_relationship.tag.organization_id,
      tag_id: item_relationship.tag_id,
      sha256: item_relationship.item_sha_256
    )
  end

  def organization
    @organization ||= Organization.find(organization_id)
  end

  def tag
    @tag ||= Tag.find(tag_id)
  end

  def tag_relationships
    organization.tag_relationships_for_item(sha256)
  end

  def model_name
    ActiveModel::Name.new(
      self.class,
      nil,
      tag.name
    )
  end

  def persisted?
    true
  end

  def to_key
    [sha256]
  end
end

class Item
  def content_text
    organization.s3_client.get_item_text(sha256)
  end
end