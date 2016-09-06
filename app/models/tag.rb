class Tag < ApplicationRecord
  belongs_to :organization
  has_many :item_relationships, class_name: 'ItemTagRelationship', dependent: :destroy

  validates :organization_id, presence: true
  validates :name, presence: true
end
