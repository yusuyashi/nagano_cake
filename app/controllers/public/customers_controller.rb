class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer 
    @orders = @customer.orders
  end 
  
  def edit
    @customer = current_customer
  end 
  
   def update
    @customer = current_customer

    if @customer.update(customer_params)
      redirect_to public_customer_path, notice: "登録情報が更新されました。"
    else
      render :edit
    end
   end
  
  def confirmation
  end 
  
  def withdrawal
  end 
  
  def after_sign_up_redirect
    redirect_to public_customer_path(current_customer)
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
