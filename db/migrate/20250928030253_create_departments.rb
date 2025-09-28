class CreateDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :departments do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :office, null: true, foreign_key: true
      t.string :name, limit: 100, null: false
      t.references :manager, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :departments, [:organization_id, :name]
  end
end
