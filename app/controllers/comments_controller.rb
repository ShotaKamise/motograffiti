class CommentsController < ApplicationController
  
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
end
