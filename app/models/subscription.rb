class Subscription < ApplicationRecord
	belongs_to :member, dependent: :destroy
	belongs_to :subscription_plan, dependent: :destroy

	validates :member, presence: true
	validates :subscription_plan, presence: true

end