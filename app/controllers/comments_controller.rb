class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_knowledge, only: %i[new create edit]
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = @knowledge.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to knowledge_path(@knowledge), notice: "コメントを作成しました"
    else
      render "comments/new", status: :unprocessable_entity
    end
  end
  
  def edit
    if @comment.user != current_user
      redirect_to knowledge_path(@knowledge), alert: "ページを閲覧する権限がありません"
    end
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to knowledge_path(@comment.knowledge), notice: "コメントを編集しました"
    else
      render "knowledges/show", status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました"
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  def set_knowledge
    @knowledge = Knowledge.find(params[:knowledge_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
