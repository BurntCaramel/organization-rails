class IndexUserOrganizationCapabilities < ActiveRecord::Migration[5.0]
  def change
    add_index :user_organization_capabilities, [:organization, :user_identifier], name: 'index_organization_user_identifier'
  end
end
