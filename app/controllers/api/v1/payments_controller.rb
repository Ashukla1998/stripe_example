
class Api::V1::PaymentsController < ApplicationController
    def create_customer
      customer = Stripe::Customer.create({
        email: params[:email],
        source: 'tok_amex' 
      })
  
      render json: { customer_id: customer.id }
      
    end
  
    def create_order_and_charge
        begin
          unless params[:amount_cents] && params[:email] && params[:customer_id]
            raise StandardError, "Missing required parameters"
          end
          order = Order.create(amount_cents: params[:amount_cents], customer_email: params[:email])
    
          charge = Stripe::PaymentIntent.create({
            amount: order.amount_cents,
            currency: 'usd',
            customer: params[:customer_id],  
            description: "Charge for Order #{order.id}"
            # payment_method: params[:payment_method]
          })
    
         
          order.update(status: 'paid')
    
          render json: { order_id: order.id, charge_id: charge.id }
        rescue Stripe::InvalidRequestError => e
          render json: { error: "Stripe Error: #{e.message}" }, status: :unprocessable_entity
        rescue StandardError => e
          render json: { error: "Error: #{e.message}" }, status: :unprocessable_entity
        rescue => e
          render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
        end
    end
  end
  