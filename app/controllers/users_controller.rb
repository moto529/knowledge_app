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
  
  def profile
    @user_knowledges = @q.result.order(created_at: 'desc')
  end
  
  private
  def set_q
    @user = User.find(params[:id])
    @q = @user.knowledges.ransack(params[:q])
  end
end
