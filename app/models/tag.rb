class Tag < ApplicationRecord
  belongs_to :organization
  has_many :item_tag_relationships, dependent: :destroy

  validates :organization_id, presence: true
  validates :name, presence: true
end
