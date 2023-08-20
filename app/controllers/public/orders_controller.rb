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
   @payment_method_display = @order.payment_method == 'credit_card' ? 'クレジットカード' : '銀行振込'
  end


  def create
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id
  @order.shipping_address = params[:order][:shipping_address]
  @order.payment_method = params[:order][:payment_method]
  if @order.save
    # 2. カート内の合計金額から請求金額を算出
    total_amount = current_customer.cart_items.sum { |item| item.item.price * item.quantity }
    @order.update(total_amount: total_amount)

    # 3. 注文詳細(OrderDetail)の保存
    current_customer.cart_items.each do |cart_item|
      OrderDetail.create(
        order_id: @order.id,
        item_id: cart_item.item.id,
        quantity: cart_item.quantity,
        purchase_price_taxIncluded: cart_item.item.price
      )
    end

    # 4. カート内商品を全て削除
    current_customer.cart_items.destroy_all

    # 5. 購入完了画面に遷移
    redirect_to public_orders_complete_path
  else
    # 注文処理が失敗した場合の処理（例：注文情報入力画面の再表示）
    @addresses = current_customer.addresses
    render :new
  end
  end


  def confirm
   @order = Order.new(order_params)
   @order.payment_method = params[:order][:payment_method]
   @order.shipping_postal_code = current_customer.postal_code
   @order.shipping_address = current_customer.address
   @order.shipping_name = current_customer.full_name
   @shipping_fee = 800
   @cart_items = current_customer.cart_items
   @sum = @cart_items.sum { |cart_item| cart_item.item.with_tax_price * cart_item.quantity }


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
