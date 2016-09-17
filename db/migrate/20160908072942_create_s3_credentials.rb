class CreateS3Credentials < ActiveRecord::Migration[5.0]
  def change
    create_table :s3_credentials do |t|
      t.references :organization, foreign_key: true, null: false
      t.binary :encrypted_info, null: false
      t.binary :encrypted_info_iv, null: false

      t.timestamps
    end
  end
end
