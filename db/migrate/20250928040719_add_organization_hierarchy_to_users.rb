class AddOrganizationHierarchyToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :office, null: true, foreign_key: true
    add_reference :users, :department, null: true, foreign_key: true
    add_reference :users, :section, null: true, foreign_key: true
  end
end
