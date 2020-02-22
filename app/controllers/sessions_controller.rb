class SessionsController < ApplicationController
  before_action :forbidden_user, {only:[:new, :create]}
  
  def new
  end
  
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to topics_path, success: "ログインしました"
    else
      flash.now[:danger] = "ログインできませんでした"
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, info: "ログアウトしました" 
  end
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
