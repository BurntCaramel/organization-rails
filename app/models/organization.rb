TEXT_TAG = 'text'
IMAGE_TAG = 'image'
RECORD_TAG = 'record'
STORY_TAG = 'story'

class Organization < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :s3_credentials, dependent: :destroy

  # Validation
  validates :owner_identifier, presence: true

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
