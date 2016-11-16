class Tag < ApplicationRecord
  belongs_to :organization
  has_many :item_relationships, class_name: 'ItemTagRelationship', dependent: :destroy

  validates :organization_id, presence: true
  validates :name, presence: true

  before_save :downcase_name

  private

    # Ensure name is all-lowercase
    def downcase_name
      self.name = self.name.downcase
    end
end
