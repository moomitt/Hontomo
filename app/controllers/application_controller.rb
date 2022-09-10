class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
    def after_sign_in_path_for(resource)
      root_path
    end
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
  
  
  before_action :authenticate_admin!, if: :admin_url
  def admin_url
    request.fullpath.include?('/admin')
  end
  # admin_urlがtrueの場合のみbefore_actionを実行
  # request.fullpath : 飛んだ先のpathを全て取得
    
end
