# config/routes.rb

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'payments/create_customer', to: 'payments#create_customer'
      post 'payments/create_order_and_charge', to: 'payments#create_order_and_charge'
    end
  end
end
