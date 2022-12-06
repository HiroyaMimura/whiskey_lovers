class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @whiskey = Whiskey.find(params[:whiskey_id])
    favorite = current_user.favorites.new(whiskey_id: @whiskey.id)
    favorite.save
    render "public/whiskey_comments/create"
  end

  def destroy
    @whiskey = Whiskey.find(params[:whiskey_id])
    favorite = current_user.favorites.find_by(whiskey_id: @whiskey.id)
    favorite.destroy
    render "public/whiskey_comments/destroy"
  end
  
end
