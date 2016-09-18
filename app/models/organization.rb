class Organization < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :s3_credentials, dependent: :destroy

  # Validation
  validates :owner_identifier, presence: true

  def story_tag
    tags.find_by name: 'story'
  end

  def image_tag
    tags.find_by name: 'image'
  end

  def record_tag
    tags.find_by name: 'record'
  end
end
