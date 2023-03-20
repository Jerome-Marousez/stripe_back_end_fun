class CreateSubscriptionPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_plans do |t|
      t.string :plan_id
      t.string :name
      t.string :currency
      t.string :interval
      t.string :product_id
      t.string :price_id
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
