class CreateRipples < ActiveRecord::Migration[5.0]
  def change
    create_table :ripples do |t|
      t.references :channel, foreign_key: true, null: false

      # Entity identifier, latest created one wins
      t.binary :key_id, limit: 16, null: false
      # JSON with :kind, :sha256, :name
      t.binary :info, null: false

      t.timestamps null: false
    end
    # For finding the latest ripple with a particular key 
    add_index :ripples, [:channel_id, :key_id, :created_at], unique: true
    # For listing all the ripples in a channel 
    add_index :ripples, [:channel_id, :created_at]
  end
end
