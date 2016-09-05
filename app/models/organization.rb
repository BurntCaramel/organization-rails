class Organization < ApplicationRecord
  has_many :tags, dependent: :destroy
  # Tags
  has_many :tag_item_relationships, class_name: 'ItemTagRelationship', foreign_key: 'organization_id', dependent: :destroy 
  has_many :tags, through: :tag_item_relationships, source: :tag

  validates :owner_identifier, presence: true
end
