class Member < ApplicationRecord
	has_one :subscription
	has_many :subscription_plan, through: :subscriptions

	validates :username, presence: true

end