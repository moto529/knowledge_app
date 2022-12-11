class KnowledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index]

  def index
    @knowledges = @q.result.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: 'desc').page(params[:page])
  end

  def new
    @knowledge = Knowledge.new
  end

  def create
    @knowledge = Knowledge.new(knowledge_params)
    @knowledge.user = current_user
    if @knowledge.save
      redirect_to knowledges_path, notice: 'ナレッジを作成しました。'
    else
      @knowledges = Knowledge.all
      render 'knowledges/new', status: :unprocessable_entity
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
  end

  def update
    @knowledge = Knowledge.find(params[:id])
    if @knowledge.update(knowledge_params)
      redirect_to knowledge_path, notice: 'ナレッジを編集しました。'
    else
      render 'knowledges/show', status: :unprocessable_entity
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to knowledges_path, notice: '削除しました。'
  end

  def timeline
    @knowledges = Knowledge.order(created_at: 'desc').page(params[:page])
  end

  private

  def set_q
    @q = Knowledge.ransack(params[:q])
  end

  def knowledge_params
    params.require(:knowledge).permit(:title, :body, :url, :category_id)
  end
end
