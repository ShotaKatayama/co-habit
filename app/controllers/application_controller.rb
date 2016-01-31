class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
