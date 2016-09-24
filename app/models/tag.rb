class Tag < ApplicationRecord
  belongs_to :organization
  has_many :item_relationships, class_name: 'ItemTagRelationship', dependent: :destroy

  before_save :downcase_name

  validates :organization_id, presence: true
  validates :name, presence: true

  private

    # Ensure name is all-lowercase
    def downcase_name
      self.name = name.downcase
    end
end
