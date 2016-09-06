class Organization < ApplicationRecord
  # Tags
  has_many :tags, dependent: :destroy 

  # Validation
  validates :owner_identifier, presence: true
end
