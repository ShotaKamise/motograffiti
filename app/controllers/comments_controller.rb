class CommentsController < ApplicationController
  
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to topics_path, success: "コメントしました"
    else
      flash.now[:danger] = "コメント出来ませんでした"
      render :new
    end
  end
  
  def edit
    @comment = Comment.find_by(id: params[:id])
  end
  
  def update
    @comment = Comment.find_by(id: params[:id])
    @comment.update(comment_params) 
    if @comment.save
      redirect_to topics_path, success: "コメントを編集しました"
    else
      flash.now[:danger] = "編集出来ませんでした"
      render :edit
    end
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to topics_path, success: "コメントを削除しました"
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment, :topic_id)
  end
  
  def ensure_correct_user
    @comment = Comment.find_by(id: params[:id])
    if current_user.id != @comment.user_id
      flash[:danger] = "権限がありません。"
      redirect_to topics_path
    end
  end
  
end
