class ApplicationController < ActionController::Base
  
  # devise機能の利用前に、configure_permitted_parametersメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ユーザログイン後、トップページにリダイレクト
  def after_sign_in_path_for(resource)
    root_path
  end
  
  # admin_url == trueの場合（adminを含むurlにアクセスした時）
  # ログイン済み管理者にのみ、全ての処理が許可される
  before_action :authenticate_admin!, if: :admin_url
  def admin_url
    # request.fullpath : 飛んだ先のpathを全て取得
    request.fullpath.include?("/admin")
  end
  
  protected
    # sign_up時に、nameのデータ操作を許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
