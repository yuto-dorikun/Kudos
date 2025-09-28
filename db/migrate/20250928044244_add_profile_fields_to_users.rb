class AddProfileFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :employee_id, :string
    add_column :users, :position, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :status, :integer, default: 1
    add_column :users, :hire_date, :date
    add_column :users, :bio, :text

    # 追加インデックス
    add_index :users, [:organization_id, :employee_id], unique: true
    add_index :users, :role
    add_index :users, :status
  end
end
