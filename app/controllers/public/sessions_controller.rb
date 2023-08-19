# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  
  def create
    super do |resource|
      if resource.persisted?
        redirect_to root_path and return
      end
    end
  end

  protected

def customer_state
  
  @customer = Customer.find_by(email: params[:customer][:email])
  
  if @customer.valid_password?(params[:customer][:password])
    if @customer.is_deleted
      # 退会済みアカウントのログインを防ぐため、エラーメッセージを表示
      flash.now[:alert] = "アカウントが退会しています。"
      render :new
    else
      # 退会していない場合、createアクションを実行する
      create
    end
  else
    # ログインに失敗した場合、エラーメッセージを表示
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
