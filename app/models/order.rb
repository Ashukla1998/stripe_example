# app/models/order.rb

class Order < ApplicationRecord
    # Assuming you have a column named 'amount_cents' to store the order amount in cents
    # monetize :amount_cents
  
    validates :amount_cents, presence: true
    validates :customer_email, presence: true
    validates :status, inclusion: { in: %w(pending paid) }
  
    # Additional associations or methods can be added as needed
  end
  