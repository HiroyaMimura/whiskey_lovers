class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
    @whiskeys = @user.whiskeys.page(params[:page]).per(5)
  end

  def edit
    @user = current_user
  end

  def unsubscribe
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted:true)
    reset_session
    flash[:notice] = "退会しました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def user_params
     params.require(:user).permit(:name,:profile_image,:email)
  end

  def ensure_guest_user
    @user = current_user
    if @user.name == "ゲストユーザー"
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to user_path(current_user)
    end
  end

end
