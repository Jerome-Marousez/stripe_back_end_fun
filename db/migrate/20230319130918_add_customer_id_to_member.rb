class AddCustomerIdToMember < ActiveRecord::Migration[7.0]
  def up
    add_column :members, :customer_id, :string unless column_exists?(:members, :customer_id)
  end

  def down
    remove_column :members, :customer_id, :string if column_exists?(:members, :customer_id)
  end
end
