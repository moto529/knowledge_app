class KnowledgesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @knowledges = Knowledge.where(user_id: current_user.id).order(created_at: "desc")
  end
  
  def new
    @knowledge = Knowledge.new
  end
  
  def create
    @knowledge = Knowledge.new(knowledge_params)
    @knowledge.user = current_user
    if @knowledge.save
      redirect_to knowledges_path, notice: "ナレッジを作成しました。"
    else
      @knowledges = Knowledge.all
      render "knowledges/new", status: :unprocessable_entity
    end
  end
  
  def show
    @knowledge = Knowledge.find(params[:id])
  end
  
  def update
    @knowledge = Knowledge.find(params[:id])
    if @knowledge.update(knowledge_params)
      redirect_to knowledges_path, notice: "ナレッジを編集しました。"
    else
      render "knowledges/show", status: :unprocessable_entity
    end
  end
  
  # def destroy
  #   @knowledge = Knowledge.find(params[:id])
  #   @knowledge.destroy
  #   redirect_to knowledges_path, notice: "削除しました。"
  # end
  
  private
  
  def knowledge_params
    params.require(:knowledge).permit(:title, :body, :url, :category_id)
  end
  
end
