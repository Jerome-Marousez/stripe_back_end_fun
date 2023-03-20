class ExternalSubscriptionService
	require "stripe"
  API_KEY = 'pk_test_51Mmyq5Gc3Gk46qknVrA3opp3CmiEGoESPB98vi3etoLAWviX8ikiXeGrbcK6SgsxTS0D0LQwU6jE1BWOeEIt0RVb00zHG6ZmjM'
  SECRET_KEY = 'sk_test_51Mmyq5Gc3Gk46qkn77qc70AsVbnHDfO6aSPN34PIiA4fMtpjVWJq2lK3kaWh1lTxMjNw5Re0hMaN4cG9DzW1X8aD00KrMSg3RX'


	def create_plan(plan_name, plan_amount, plan_currency, plan_interval)
		Stripe.api_key = SECRET_KEY

    product = Stripe::Product.create({
      name: plan_name
    })

    if product.present?
      self.create_price(plan_name, plan_amount, plan_currency, plan_interval, product)
		else
      render json: { error: 'could not create product' }, status: 404
		end
	end

	def delete_plan(id)
		Stripe.api_key = SECRET_KEY

		plan = SubscriptionPlans.find(id)
		response_plan = Stripe::Plan.delete(plan.plan_id)

		if response_plan.present?
			response_product = Stripe::Product.delete(plan.product)
			if response_product.present?
				plan.destroy
			else
				render json: { error: 'could not delete product on Stripe' }, status: 404
			end
		else
			render json: { error: 'could not delete plan on Stripe' }, status: 404
		end
	end

	def subscribe(plan, member, product_id)
		Stripe.api_key = SECRET_KEY

		unless member.customer_id.present?
			self.create_customer(plan, member, product_id)
		else
		  self.create_subscription(plan, member)
		end
	end

	private

	# ====================================================================================
	# ============================ SUBSCRIPTION PLANS ====================================
	# ====================================================================================

	def create_price(plan_name, plan_amount, plan_currency, plan_interval, product)
		Stripe.api_key = SECRET_KEY

		@price = Stripe::Price.create({
      unit_amount: plan_amount,
      currency: plan_currency,
      recurring: { interval: plan_interval },
      product: product.id,
    })

    if @price.present?
      self.create_stripe_plan(plan_name, plan_amount, plan_currency, plan_interval, product)
    else
      render json: { error: 'could not create price' }, status: 404
    end
	end

	def create_stripe_plan(plan_name, plan_amount, plan_currency, plan_interval, product)
		Stripe.api_key = SECRET_KEY

		plan = Stripe::Plan.create({
      amount: plan_amount,
      currency: plan_currency,
      interval: plan_interval,
      product: product.id,
      nickname: product.name,
    })

    if plan.present?
      self.create_subscription_plan(plan, plan_amount, plan_currency, plan_interval, product)
    else
      render json: { error: 'could not create plan' }, status: 404
    end
	end

	def create_subscription_plan(plan, plan_amount, plan_currency, plan_interval, product)
		Stripe.api_key = SECRET_KEY

    SubscriptionPlan.create({
      plan_id: plan.id,
      price_id: @price.id,
      name: product.name,
      currency: plan_currency,
      interval: plan_interval,
      product_id: product.id,
      amount: plan_amount,
      description: product.description,
    })
	end

	# ====================================================================================
  # ================================= SUBSCRIPTIONS ====================================
  # ====================================================================================

	def create_customer(plan, member, product_id)
		Stripe.api_key = SECRET_KEY

		@customer = Stripe::Customer.create({
      name: member.username,
    })

    if @customer.present?
      member.customer_id = @customer.id
      member.save

      payment_method = Stripe::PaymentMethod.create({
        type: 'card',
        card: {
          number: '4242424242424242',
          exp_month: 8,
          exp_year: 2024,
          cvc: '314',
        },
      })

      payment_method_attached = Stripe::PaymentMethod.attach(
        payment_method.id,
        { customer: @customer.id },
      )

      updated_customer = Stripe::Customer.update(
        @customer.id,
        { invoice_settings: { default_payment_method: payment_method.id } },
      )

			if [payment_method, payment_method_attached, updated_customer].all?(&:present?)
				self.create_subscription(plan, member)
			else
        render json: { error: "there was an issue creating the customer" }, status: 404
			end
    else
      render json: { error: "there was an issue creating the customer" }, status: 404
    end
	end

	def create_subscription(plan, member)
		Stripe.api_key = SECRET_KEY

		subscription = Stripe::Subscription.create({
	    customer: member.customer_id,
	    items: [
	      { price: plan.price_id },
	    ],
	  })

	  if subscription.present?
	    Subscription.create({
	      member_id: member.id,
	      subscription_plan_id: plan.id
	    })
    else
      render json: { error: "there was an issue creating the subscription" }, status: 404
    end
	end

end