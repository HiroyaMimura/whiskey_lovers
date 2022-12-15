class Admin::WhiskeysController < ApplicationController
 before_action :authenticate_admin!

  def show
   @whiskey = Whiskey.find(params[:id])
   @comments = @whiskey.whiskey_comments.order('created_at DESC').page(params[:page]).per(4)
  end

  def destroy
   @whiskey = Whiskey.find(params[:id])
   @whiskey.destroy
   redirect_to admin_root_path
  end

end
