class SubscriptionPlan < ApplicationRecord
	has_many :subscriptions
	has_many :members, through: :subscriptions

	def self.find_by_product_id(product)
		find_by("product", product)
	end

	def subscriber_count
		plan = SubscriptionPlan.find(id)
		plan.members.count
	end

end