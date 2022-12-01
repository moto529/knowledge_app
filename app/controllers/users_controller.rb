class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @knowledges = @user.knowledges.order(created_at: 'desc')
    if @user.id == current_user.id
      redirect_to knowledges_path
    end
  end
end
