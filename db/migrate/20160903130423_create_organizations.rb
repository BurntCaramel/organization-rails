class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :owner_identifier

      t.timestamps
    end
    add_index :names, [:name], unique: true
  end
end
