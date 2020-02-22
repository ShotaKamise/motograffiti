class UsersController < ApplicationController
  before_action :forbidden_user, {only: [:new, :create]}
  before_action :authenticate_user, {only: [:message, :followings]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to topics_path, success: "登録しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    #if @user.update!( name: user_params[:name], email: user_params[:email], recent_info: user_params[:recent_info] )
    
    @user.name = user_params[:name]
    @user.email = user_params[:email]
    @user.image = user_params[:image]
    @user.user_background = user_params[:user_background]
    @user.recent_info = user_params[:recent_info]
    
    if @user.save
      redirect_to user_path(id: @user.id), success: "ユーザー情報を更新しました"
    else
      flash.now[:danger] = "ユーザー情報を更新出来ませんでした。"
      render :edit
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
  
  def followings
    user = User.find_by(id: params[:id])
    @following_users = user.followings.all
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :user_background, :recent_info)
  end
  
  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:danger] = "権限がありません。"
      redirect_to topics_path
    end
  end
  
end
