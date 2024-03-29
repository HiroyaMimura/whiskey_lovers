# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :check_captcha, only: [:create]
  before_action :user_state, only: [:create]

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

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = 'ゲストログインしました。'
    redirect_to whiskeys_path
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = 'ログインしました。'
    whiskeys_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = 'ログアウトしました。'
    root_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  # end

# 退会しているかを判断するメソッド
  def user_state
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        flash[:notice] = "退会済みです。再度、ご登録いただきご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "入力が正しくありません。"
      end
    end
  end

  def check_captcha
    self.resource = resource_class.new sign_in_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
  end

end
