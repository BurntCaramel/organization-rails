class Channel < ApplicationRecord
  belongs_to :organization
  has_many :ripples, dependent: :destroy

  before_save :downcase_name

  validates :organization, presence: true
  validates :name, presence: true

  private

    # Ensure name is all-lowercase
    def downcase_name
      self.name = name.downcase
    end
end
