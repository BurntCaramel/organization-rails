class AddNameToChannel < ActiveRecord::Migration[5.0]
  def self.up
    # Two steps, see: http://stackoverflow.com/a/6710280/652615
    add_column :channels, :name, :string
    change_column :channels, :name, :string, null: false
    
    add_index :channels, [:organization_id, :name], unique: true
  end

  def self.down
    remove_column :channels, :name
    remove_index :channels, [:organization_id, :name]
  end
end
