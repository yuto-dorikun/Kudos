class CreateOffices < ActiveRecord::Migration[7.2]
  def change
    create_table :offices do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, limit: 100, null: false
      t.string :address
      t.boolean :is_headquarters,default: false

      t.timestamps
    end
    add_index :offices, [:organization_id, :name]
  end
end
