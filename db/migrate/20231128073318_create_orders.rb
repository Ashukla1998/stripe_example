class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :amount_cents
      t.string :customer_email
      t.string :status

      t.timestamps
    end
  end
end
