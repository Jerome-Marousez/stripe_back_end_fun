class V1::SubscriptionsController < V1::ApiController
	protect_from_forgery except: [:create, :update]

	before_action :set_subscription_data, only: [:create, :update]

	def index

	end

	def show

	end

	def create
		params_present = [@subscription_plan_id, @member_id, @product_id].all?(&:present?)
		if params_present
			@plan = SubscriptionPlan.find_by(product: @product_id)
			@member = Member.find(@member_id)
			ExternalSubscriptionService.new.subscribe(
				@plan,
				@member,
				@product_id,
			)
		else
			render json: { error: "a product_id, member_id, and a subscription_plan_id are required" }, status: 404 unless @plan.present?
		end
	end

	private

	def set_subscription_data
		@subscription_plan_id = params.dig("subscription_plan_id")
		@member_id = params.dig("member_id")
		@product_id = params.dig("product_id")
	end

end