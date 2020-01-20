class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: "登録しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find_by(id: current_user.id)
  end
  
  def update
    @user = User.find_by(id: current_user.id)
    @user.name = user_params[:name]
    if @user.save
      redirect_to user_path, success: "ユーザー情報を更新しました"
    else
      flash.now[:danger] = "ユーザー情報を更新出来ませんでした。"
      render :edit
    end
  end
  
  def show
    @user = User.find_by(id: current_user.id)
    @topics = @user.topics.all
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :user_background, :recent_info)
  end
  
end
