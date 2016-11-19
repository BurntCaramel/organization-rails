class UserOrganizationCapability < ApplicationRecord
  include CapabilitiesConcern

  belongs_to :organization

  scope :by_user, -> (user) { where(user: user) }

  def admin?
    capabilities.include?(:admin)
  end

  def member?
    capabilities.include?(:member)
  end

  def invite?
    admin? || capabilities.include?(:invite)
  end

  def publish_content?
    admin? || capabilities.include?(:publish_content)
  end
end
