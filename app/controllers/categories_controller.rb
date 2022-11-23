class CategoriesController < ApplicationController
  
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
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
