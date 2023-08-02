class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total_price = @cart_items.sum { |cart_item| cart_item.subtotal }
  end
  
  def create
  # 1. 追加した商品がカート内に存在するかの判別
  @cart_item = CartItem.find_by(item_id: cart_item_params[:item_id], customer_id: current_customer.id)

  if @cart_item.present?
    # 存在した場合
    # 2. カート内の個数をフォームから送られた個数分追加する
    @cart_item.quantity += cart_item_params[:quantity].to_i
  else
    # 存在しなかった場合
    # カートモデルにレコードを新規作成する
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
  end

  # カートアイテムの保存などの処理を行う（例：カートに追加する）
  if @cart_item.save
    redirect_to public_cart_items_path, notice: "カートに商品を追加しました。"
  else
    flash[:alert] = "カートに商品を追加できませんでした。数量を選択してください。"
    redirect_to public_item_path(@cart_item.item)
  end
end

 def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path, notice: "カートの商品を更新しました。"
    else
      flash[:alert] = "カートの商品を更新できませんでした。"
      redirect_to public_cart_items_path
    end
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path, notice: "カート内商品を削除しました。"
  end
  
  def destroy_all
    CartItem.destroy_all
    redirect_to public_cart_items_path, notice: "カート内の全ての商品を削除しました。"
  end
  
  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
