class LikesController < ApplicationController
  def index
    @liked_topics = current_user.liked_topics
  end
  
  def create
    like = Like.new
    like.user_id = current_user.id
    like.topic_id = params[:topic_id]
    
    if like.save
      redirect_to topics_path, success: "いいねしました"
    else
      redirect_to topics_path, danger: "いいね出来ませんでした"
    end
  end
  
  def destroy
    like = Like.find_by(user_id: current_user.id, topic_id: params[:topic_id])
    like.destroy
    redirect_to topics_path, danger: "いいねを取り消しました"
  end
end
