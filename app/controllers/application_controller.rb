class ApplicationController < ActionController::Base
  #before_action :authenticate_user! #ログイン画面に遷移
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: 
    [:name, :profile, :position, :occupation])
    #name等の値の保存
  end
end
