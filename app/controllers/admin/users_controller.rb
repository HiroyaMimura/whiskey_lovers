class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order('created_at DESC').page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @whiskeys = @user.whiskeys.order('created_at DESC').page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render "edit"
    end
  end

  private

  def user_params
     params.require(:user).permit(:name,:profile_image,:email,:is_deleted)
  end

end
