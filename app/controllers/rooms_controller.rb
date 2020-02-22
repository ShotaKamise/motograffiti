class RoomsController < ApplicationController
  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(:room_id => @room.id, :user_id => params[:user_id])
    
    redirect_to "/rooms/#{@room.id}?user_id="+params[:user_id].to_s
  end
  
  def show
    
    respond_to do |format|
      format.html {
        @room = Room.find(params[:id])
        @user_id = params[:user_id]
        if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
          @messages = @room.messages.includes(:user)
          @message = Message.new
          @entries = @room.entries.includes(:user)
          
          lastMessageId = 0
          
          if @messages.count > 0
            lastMessageId = @messages.last.id;
          end
        else
          redirect_to user_path(id: params[:user_id])
        end
      }
        
      format.json {
        newmessages = Message.where('id > ? AND room_id = ?', params[:message][:id], params[:message][:room_id])
        newmessages.each do |newmessage|
          @newmessage = newmessage
        end
      }
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :user_id)
  end
  
end
