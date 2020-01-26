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
    @user.email = user_params[:email]
    @user.image = user_params[:image]
    @user.user_background = user_params[:user_background]
    @user.recent_info = user_params[:recent_info]
    
    if @user.save
      redirect_to user_path, success: "ユーザー情報を更新しました"
    else
      flash.now[:danger] = "ユーザー情報を更新出来ませんでした。"
      render :edit
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def message
    @user = User.find_by(id: params[:id])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end
  
  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :user_background, :recent_info)
  end
  
end
