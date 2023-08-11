class Admin::OrderDetailsController < ApplicationController
   before_action :set_order_detail, only: [:show, :edit, :update, :destroy]

  def show
    # 特定の注文詳細を表示するためのアクション
  end

  # 他のアクション（edit, update, destroy）に関するコードも追加可能

  private

  def set_order_detail
    @order_detail = OrderDetail.find(params[:id])
  end
end
