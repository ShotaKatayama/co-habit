class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:user_name)
  end


=begin
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # sign_inのときに、group_keyも許可する
    devise_parameter_sanitizer.for(:sign_in) << :group_key
    # sign_upのときに、group_keyも許可する
    devise_parameter_sanitizer.for(:sign_up) << :group_key
    #account_updateのときに、group_keyも許可する
    devise_parameter_sanitizer.for(:account_update) << :group_key
  end
=end

  before_action :authenticate_user!
  #ユーザーがログインしているかどうかを確認し、ログインしていない場合はログインページにリダイレクト

=begin
  def move_to_login
    redirect_to "/users/sign_in"
  end
=end

=begin
  def after_sign_out_path_for(resource)
     "http://d.hatena.ne.jp/hichiriki/20120301"
  end
=end

=begin
  def after_sign_in_path_for(resource)
     ""
  end
=end

end
