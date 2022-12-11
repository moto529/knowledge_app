# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update profile set_q]
  before_action :set_q, only: [:profile]
  def show
    @user_knowledges = @user.knowledges.order(created_at: 'desc').page(params[:page])
    return unless @user == current_user

    redirect_to profile_user_path
  end

  def edit
    return unless current_user != @user

    redirect_to profile_user_path, alert: '自分以外のプロフィールは作成できません。'
  end

  def update
    if @user.update(user_params_update)
      redirect_to profile_user_path, notice: 'プロフィールを保存しました。'
    else
      render 'users/edit', status: :unprocessable_entity
    end
  end

  def profile
    if current_user != @user
      redirect_to user_path
    else
      @profile_knowledges = @q.result.order(created_at: 'desc').page(params[:page])
    end
  end

  def favorite
    @favorites = current_user.favorite_knowledges.includes(:user).order(created_at: 'desc').page(params[:page])
  end

  private

  def set_q
    @q = @user.knowledges.ransack(params[:q])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params_update
    params.require(:user).permit(:introduction, :profile_image)
  end
end
