class RenameS3CredentialToServiceCredential < ActiveRecord::Migration[5.0]
  def change
    rename_table :s3_credentials, :service_credentials
  end
end
