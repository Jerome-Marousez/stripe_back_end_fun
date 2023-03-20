class Member < ApplicationRecord
	has_one :subscription
	has_one :subscription_plan, through: :subscription

	validates :username, presence: true

end