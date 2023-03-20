Rails.application.routes.draw do

	namespace :v1 do
    resources :members, except: [ :edit, :destroy]
    resources :subscription_plans, except: [:new, :edit]
    resources :subscriptions, except: [:new, :edit, :destroy]
	end

end
