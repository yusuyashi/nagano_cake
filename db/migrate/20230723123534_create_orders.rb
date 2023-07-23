class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :shipping_address, null: false
      t.string :shipping_postal_code, null: false
      t.string :shipping_name, null: false
      t.decimal :shipping_fee, null: false
      t.integer :payment_method, null: false, default: 0
      t.decimal :total_amount, null: false

      t.timestamps
    end
  end
end
