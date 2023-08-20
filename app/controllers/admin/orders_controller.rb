class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @payment_method_display = @order.payment_method == 'credit_card' ? 'クレジットカード' : '銀行振込'
  end
end
