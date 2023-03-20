class V1::SubscriptionPlansController < V1::ApiController

	protect_from_forgery except: [:create, :update, :destroy]
	before_action :set_plan_data, only: [:create, :update]
	before_action :set_defaults, only: [:create, :update]

	def index
		@plans = SubscriptionPlan.all
	end

	def show
		render json: { message: "show" }, status: :ok
	end

	def create
		params_present = [@plan_name, @plan_amount].all?(&:present?)
		if params_present
			@plan = ExternalSubscriptionService.new.create_plan(
				@plan_name,
				@plan_amount,
				@plan_currency,
				@plan_interval
			)
		else
			render json: { error: 'plan_name and plan_amount are required' }, status: 404
		end
	end

	def destroy
		@plan = ExternalSubscriptionService.new.delete_plan(params.dig("id"))
	end

	private

	def set_plan_data
		@plan_name = params.dig("name")
		@plan_amount = params.dig("amount")
		@plan_currency = params.dig("currency")
		@plan_interval = params.dig("interval")
	end

	def set_defaults
		@plan_currency ||= "gbp"
		@plan_interval ||= "month"
	end

end