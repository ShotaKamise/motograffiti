class MessagesController < ApplicationController
  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_to user_path(id: params[:user_id])
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
