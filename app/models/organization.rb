TEXT_TAG = 'text'
IMAGE_TAG = 'image'
RECORD_TAG = 'record'
STORY_TAG = 'story'

class Organization < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :service_credentials, dependent: :destroy
  has_many :item_tag_relationships, through: :tags, source: :item_relationships

  # Validation
  validates :owner_identifier, presence: true
end

class Organization
  def tag_relationships_for_item(item_sha_256)
    #item_tag_relationships = ItemTagRelationship.joins(:tag).where('tag.organization = ?', self)
    item_tag_relationships.where(item_sha_256: item_sha_256).includes(:tag)
  end

  def item_tag_relationships_with_tags(tags)
    tags = tags.uniq # Reduce when tags are the same
    item_tag_relationships.where(tag_id: tags).group(:item_sha_256).having('COUNT(*) >= ?', tags.count)
  end

  def text_tag
    tags.find_by name: TEXT_TAG
  end

  def image_tag
    tags.find_by name: IMAGE_TAG
  end

  def record_tag
    tags.find_by name: RECORD_TAG
  end

  def story_tag
    tags.find_by name: STORY_TAG
  end
end

class Organization
  def s3_client
    @s3_client ||= OrganizationS3Client.new(self)
  end
end
