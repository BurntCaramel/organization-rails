TEXT_TAG = 'text'
IMAGE_TAG = 'image'
RECORD_TAG = 'record'
STORY_TAG = 'story'

class Organization < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :s3_credentials, dependent: :destroy
  has_many :item_tag_relationships, through: :tags, source: :item_relationships

  # Validation
  validates :owner_identifier, presence: true

  def tag_relationships_for_item(item_sha_256)
    #item_tag_relationships = ItemTagRelationship.joins(:tag).where('tag.organization = ?', self)
    item_tag_relationships.where({ item_sha_256: item_sha_256 }).includes(:tag)
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
