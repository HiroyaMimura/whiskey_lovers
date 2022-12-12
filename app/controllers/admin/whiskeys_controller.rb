class Admin::WhiskeysController < ApplicationController
 before_action :authenticate_admin!

  def show
   @whiskey = Whiskey.find(params[:id])
  end

  def destroy
   @whiskey = Whiskey.find(params[:id])
   @whiskey.destroy
   redirect_to admin_root_path
  end

end
