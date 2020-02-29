class RelationshipsController < ApplicationController
  
  def create
    user = set_user
    following = current_user.follow(user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to topics_path
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to topics_path
    end
  end
  
  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to topics_path
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to topics_path
    end  
  end
  
  def index
    @following_users = Relationship.where(user_id: params[:id]).order(created_at: "DESC")
    @following_users.each do |following_user|
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: following_user.id)
      
      unless following_user.id == current_user.id
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
  end
  
  private
  
  def set_user
     User.find(params[:follow_id])
  end
  
end
