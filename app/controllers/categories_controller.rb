class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index]

  def index
    @category = Category.new
    @results = @q.result
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'カテゴリーを作成しました。'
    else
      @results = @q.result
      render 'categories/index', status: :unprocessable_entity
    end
  end

  private

  def set_q
    @q = Category.ransack(params[:q])
  end

  def category_params
    params.require(:category).permit(:category_name)
  end
end
