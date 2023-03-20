class SubscriptionPlan < ApplicationRecord
	has_many :subscription
	has_many :member, through: :subscriptions

	def self.find_by_product_id(product)
		find_by("product", product)
	end

end