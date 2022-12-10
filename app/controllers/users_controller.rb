class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:profile]
  def show
    @user = User.find(params[:id])
    @knowledges = @user.knowledges.order(created_at: 'desc')
    if @user.id == current_user.id
      redirect_to profile_user_path
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      redirect_to profile_user_path, notice: 'プロフィールを保存しました。'
    else
      render "users/edit", status: :unprocessable_entity
    end
  end
  
  def profile
    @knowledges = @q.result.order(created_at: 'desc')
  end
  
  def favorite
    @knowledges = current_user.favorite_knowledges.includes(:user).order(created_at: 'desc')
  end
  
  private
  def set_q
    @user = User.find(params[:id])
    @q = @user.knowledges.ransack(params[:q])
  end
  
  def user_params_update
    params.require(:user).permit(:introduction, :profile_image)
  end
end
