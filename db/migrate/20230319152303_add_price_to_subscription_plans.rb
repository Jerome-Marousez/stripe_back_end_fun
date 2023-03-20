class AddPriceToSubscriptionPlans < ActiveRecord::Migration[7.0]
  def up
    add_column :subscription_plans, :price_id, :string unless column_exists?(:subscription_plans, :price_id)
  end

  def down
    remove_column :subscription_plans, :price_id, :string if column_exists?(:subscription_plans, :price_id)
  end
end
