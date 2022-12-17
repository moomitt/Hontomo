# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # 未登録・退会済みのユーザは、登録しかできない
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
    # ユーザの登録状態（登録中／未登録／退会済み）を判断するメソッド
    def user_state
      # 入力されたemailからアカウントを1件取得
      @user = User.find_by(email: params[:user][:email])
      # アカウントを取得できなかった場合(=未登録)、メソッドを中断
      return if !@user
      # 取得アカウントのパスワードと入力パスワードが一致　かつ　アカウントが退会状態の場合
      if @user.valid_password?(params[:user][:password]) && @user.is_deleted?
        # 登録ページにリダイレクト
        redirect_to new_user_registration_path
      end
    end
  # 未登録でも退会済みでもない場合のみ、メソッドが完了する

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
