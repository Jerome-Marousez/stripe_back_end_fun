class CreateSubscriptionPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_plan do |t|
      t.string :plan_id
      t.string :name
      t.string :currency
      t.string :interval
      t.string :product
      t.integer :amount
      t.string :description
      t.integer :subscriptions

      t.timestamps
    end
  end
end
