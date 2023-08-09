class Public::OrdersController < ApplicationController
 before_action :set_customer, only: [:new, :create]

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end


  def index
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page])
  end

  def show
     @order = current_customer.orders.find(params[:id])
  end

  def create

    @order = Order.new(order_params)
    if @order.save
      # 注文処理が成功した場合の処理（例：注文完了画面へのリダイレクト）
      redirect_to public_orders_complete_path
    else
      # 注文処理が失敗した場合の処理（例：注文情報入力画面の再表示）
      @addresses = current_customer.addresses
      render :new
    end
  end

  def confirm
   @order = Order.new(order_params)
   @order.shipping_postal_code = current_customer.postal_code
   @order.shipping_address = current_customer.address
   @order.shipping_name = current_customer.full_name
   @shipping_fee = 500

   @cart_items = current_customer.cart_items
  end


  def complete

  end



  private

  def set_customer
    @customer = current_customer
  end

  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_postal_code, :shipping_address, :shipping_name, :customer_id, :total_amount, :shipping_fee)
  end


end
