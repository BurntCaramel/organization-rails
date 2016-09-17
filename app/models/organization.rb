class Organization < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :s3_credentials, dependent: :destroy

  # Validation
  validates :owner_identifier, presence: true
end
