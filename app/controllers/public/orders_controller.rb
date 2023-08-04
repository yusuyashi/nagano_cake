class Public::OrdersController < ApplicationController
 before_action :set_customer, only: [:new, :create]

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  
  def index
  end 
  
  def show
  end 
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_address = params[:order][:shipping_address] 
    
    if @order.save
      # 注文処理が成功した場合の処理（例：注文完了画面へのリダイレクト）
      redirect_to public_order_completed_path
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
   
   @cart_items = current_customer.cart_items 
  end

  
  def complete
  end 
  
  private

  def set_customer
    @customer = current_customer
  end

  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_postal_code, :shipping_address, :shipping_name)
  end


end
