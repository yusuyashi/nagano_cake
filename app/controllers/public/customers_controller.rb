class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer 
    @orders = @customer.orders
  end 
  
  def edit
  end 
  
  def update
  end 
  
  def confirmation
  end 
  
  def withdrawal
  end 
  
  def after_sign_up_redirect
    redirect_to public_customer_path(current_customer)
  end
end
