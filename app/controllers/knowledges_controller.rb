class KnowledgesController < ApplicationController
  before_action :authenticate_user!
  def new
    @knowledge = Knowledge.new
    @knowledges = Knowledge.all
  end
  
  def create
    @knowledge = Knowledge.new(knowledge_params)
    @knowledge.user = current_user
    if @knowledge.save!
      redirect_to new_knowledge_path
    else
      @knowledges = Knowledge.all
      render "knowledges/new", status: :unprocessable_entity
    end
  end
  
  private
  
  def knowledge_params
    params.require(:knowledge).permit(:title, :body, :url, :category_id)
  end
  
end
