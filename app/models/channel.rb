class Channel < ApplicationRecord
  belongs_to :organization
  has_many :ripples, dependent: :destroy

  validates :organization, presence: true
end
