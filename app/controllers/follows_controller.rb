class FollowsController < ApplicationController
  def create
    @follow = Follow.new(user_id: params[:user_id])
    
    if @follow.save
      redirect_to topics_path, success: "いいねしました"
    else
      redirect_to topics_path, danger: "いいね出来ませんでした"
    end
    
  end
  
  def index
    @follows = Follow.where()
  
  end
end
