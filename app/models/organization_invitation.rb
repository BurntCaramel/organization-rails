class OrganizationInvitation < ApplicationRecord
  include CapabilitiesConcern
  
  belongs_to :organization

  validates :organization, presence: true
  validates :email, presence: true
end
