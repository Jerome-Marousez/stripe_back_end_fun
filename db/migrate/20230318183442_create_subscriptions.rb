class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :member
      t.belongs_to :subscription_plan

      t.timestamps
    end
  end
end
