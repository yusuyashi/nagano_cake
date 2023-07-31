class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました。"
    else
      render :new
    end
  end
  
  def index
    @items = Item.paginate(page: params[:page], per_page: 10)
  end 
  
  def show
  end 
  
  
  def confirm
  end 
  
  def complete
  end 
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
