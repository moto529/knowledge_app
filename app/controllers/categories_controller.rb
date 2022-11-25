class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "カテゴリーを作成しました。"
    else
      @categories = Category.all
      render "categories/index", status: :unprocessable_entity
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:category_name)
  end
  
end
