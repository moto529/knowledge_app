# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    knowledge = Knowledge.find(params[:knowledge_id])
    current_user.favorite(knowledge)
    redirect_back fallback_location: root_path
  end

  def destroy
    knowledge = current_user.favorites.find(params[:id]).knowledge
    current_user.unfaborite(knowledge)
    redirect_back fallback_location: root_path
  end
end
