class AddKindToServiceCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column :service_credentials, :kind, :string
    ServiceCredential.update_all(kind: ServiceCredential::S3_ACCESS_SERVICE_ID)
    change_column :service_credentials, :kind, :string, null: false
    add_index :service_credentials, [:organization_id, :kind], unique: true
  end
end
