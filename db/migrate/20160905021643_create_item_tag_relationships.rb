class CreateItemTagRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :item_tag_relationships do |t|
      t.references :tag, foreign_key: true, null: false
      t.string :item_sha_256, null: false

      t.timestamps
    end
    add_index :item_tag_relationships, [:tag_id, :item_sha_256], unique: true, name: 'by_tag_item'
    add_index :item_tag_relationships, [:item_sha_256], name: 'by_item'
  end
end
