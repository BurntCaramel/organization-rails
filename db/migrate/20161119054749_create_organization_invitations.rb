class CreateOrganizationInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :organization_invitations do |t|
      t.references :organization, foreign_key: true
      t.string :email
      t.string :capabilities

      t.timestamps
    end
  end
end
