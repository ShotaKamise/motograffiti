class TopicsController < ApplicationController
  
  before_action :authenticate_user, {only: [:create, :new, :index]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  
  def index
    @topics = Topic.all.includes(:like_users, :comments).order(created_at: "DESC")
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
    @topic = Topic.find_by(id: params[:id])
    @topic.title = topic_params[:title]
    if topic_params[:image]
      @topic.image = topic_params[:image]
    end
    @topic.contents = topic_params[:contents]
    @topic.parking_info = topic_params[:parking_info]
    @topic.restaurant_info = topic_params[:restaurant_info]
    
    if @topic.save!
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
  
  def search
   @search_topics = Topic.search(params[:search]).includes(:like_users, :comments).order(id: "DESC")
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :contents, :parking_info, :restaurant_info, :title)
  end
  
  def ensure_correct_user
    @topic = Topic.find_by(id: params[:id])
    if current_user.id != @topic.user_id
      flash[:danger] = "権限がありません。"
      redirect_to topics_path
    end
  end
  
end
