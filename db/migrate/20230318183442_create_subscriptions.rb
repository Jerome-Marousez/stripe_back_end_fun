class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :member, index: { unique: true }, foreign_key: true
      t.belongs_to :subscription_plan, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
