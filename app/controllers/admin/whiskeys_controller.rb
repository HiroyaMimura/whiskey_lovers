class Admin::WhiskeysController < ApplicationController
 before_action :authenticate_admin!

  def show
   @whiskey = Whiskey.find(params[:id])
  end

  def destroy
  end

end
