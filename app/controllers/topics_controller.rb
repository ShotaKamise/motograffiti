class TopicsController < ApplicationController
  
  def index
    @topics = Topic.all.includes(:like_users).order(updated_at: "DESC")
  end
  
  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  def edit
    @topic = Topic.find_by(id: params[:id])
  end
  
  def update
    @topic = Topic.find_by(id: topic_id)
    @topic.title = topic_params[:title]
    @topic.image = topic_params[:image]
    @topic.contents = topic_params[:contents]
    @topic.parking_info = topic_params[:parking_info]
    @topic.restaurant_info = topic_params[:restaurant_info]
    
    if @topic.save
      redirect_to topics_path, success: '投稿を編集しました'
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find_by(id: params[:id])
    @topic.delete
    redirect_to topics_path, success: '投稿を削除しました'
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :contents, :parking_info, :restaurant_info, :title)
  end
end
