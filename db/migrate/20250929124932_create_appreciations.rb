class CreateAppreciations < ActiveRecord::Migration[7.2]
  def change
    create_table :appreciations do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.text :message, null: false
      t.integer :category, null: false
      t.boolean :is_public, default: true
      t.integer :likes_count, default: 0
      t.timestamps
    end
    # インデックス最適化
    add_index :appreciations, [:organization_id, :receiver_id]
    add_index :appreciations, [:organization_id, :sender_id]
    add_index :appreciations, [:organization_id, :created_at]
    add_index :appreciations, :category
  end
end
