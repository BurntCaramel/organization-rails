class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.references :organization, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
    add_index :tags, [:organization_id, :name], unique: true
  end
end

###
# tag = Tag.find(organization: organization, name: "foo")
# tag.item_relationships
# items_with_tag = ItemTagRelationship.find(organization: organization, tag: tag).pluck(:item_sha_256)
# tags_for_item = ItemTagRelationship.find(organization: organization, item_sha_256: item_sha_256).pluck(:tag)
###
