class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    #ユーザが受け取る通知の全てをindexページを開いた瞬間に通知のcheckedは全てtrueに変える
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
    notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
