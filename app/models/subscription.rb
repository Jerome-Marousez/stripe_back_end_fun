class Subscription < ApplicationRecord
	belongs_to :member, dependent: :destroy
	belongs_to :subscription_plan, dependent: :destroy

end