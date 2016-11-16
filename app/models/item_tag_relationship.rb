class ItemTagRelationship < ApplicationRecord
  belongs_to :tag

  before_validation :downcase_sha_256
  validates :item_sha_256, length: { is: 64 }, format: { with: /[a-f0-9]{64}/ }

  private
    def downcase_sha_256
      @item_sha_256 = item_sha_256.downcase if item_sha_256.is_a? String
    end
end

class ItemTagRelationship
  def item
    @item ||= Item.from_tag_relationship self
  end
end
