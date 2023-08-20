# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  
    
  def create
    email = params[:customer][:email]
    password = params[:customer][:password]

    if email.blank? || password.blank?
      flash.now[:alert] = "メールアドレスとパスワードを入力してください。"
      render :new
      return
    end

    super do |resource|
      if resource.persisted?
        redirect_to root_path and return
      end
    end
  end

  protected

  def customer_state
    email = params[:customer][:email]
    password = params[:customer][:password]

    if email.blank? || password.blank?
      flash.now[:alert] = "メールアドレスとパスワードを入力してください。"
      render :new
      return
    end

    @customer = Customer.find_by(email: email)

    if @customer&.valid_password?(password)
      if @customer.is_deleted
        flash.now[:alert] = "アカウントが退会しています。"
        render :new
      else
        create
      end
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :new
    end
  end



  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
