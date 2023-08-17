class ChangeDatatypeTotalAmountOfOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :total_amount, :integer
  end
end
