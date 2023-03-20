class Member < ApplicationRecord
	has_one :subscription
	has_many :subscription_plan, through: :subscriptions

end