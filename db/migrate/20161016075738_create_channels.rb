class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.references :organization, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
