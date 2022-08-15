# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
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

  protected
  def user_state    #退会しているか判断するメソッド
    @user = User.find_by(email: params[:user][:email])    #入力されたemailからアカウントを1件取得
    return if !@user                                      #アカウントを取得できなかった場合、メソッドを中断
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted?
      #取得アカウントのパスワードと入力パスワードが一致　かつ　アカウントが退会状態の場合
      redirect_to new_user_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
