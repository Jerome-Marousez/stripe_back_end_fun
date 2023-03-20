json.subscription_plans do
  json.array! @plans, partial: 'subscription_plans', as: :plan
end