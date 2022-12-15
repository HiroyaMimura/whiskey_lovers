class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @whiskey = Whiskey.find(params[:whiskey_id])
    favorite = current_user.favorites.new(whiskey_id: @whiskey.id)
    favorite.save
    @whiskey.create_notification_favorite(current_user)
    @comments = @whiskey.whiskey_comments.order('created_at DESC').page(params[:page]).per(4)
    render "public/whiskey_comments/create"
  end

  def destroy
    @whiskey = Whiskey.find(params[:whiskey_id])
    favorite = current_user.favorites.find_by(whiskey_id: @whiskey.id)
    favorite.destroy
    @comments = @whiskey.whiskey_comments.order('created_at DESC').page(params[:page]).per(4)
    render "public/whiskey_comments/destroy"
  end

end
