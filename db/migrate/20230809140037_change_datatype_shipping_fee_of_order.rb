class ChangeDatatypeShippingFeeOfOrder < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :shipping_fee, :integer
  end
end
