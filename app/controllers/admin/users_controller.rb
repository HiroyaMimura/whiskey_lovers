class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @whiskeys = @user.whiskeys
  end
  
  def update
  end
  
end
