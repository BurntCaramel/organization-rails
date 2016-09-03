class CreateUserOrganizationCapabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :user_organization_capabilities do |t|
      t.references :organization, foreign_key: true
      t.string :user_identifier
      t.string :capabilities

      t.timestamps
    end
  end
end
