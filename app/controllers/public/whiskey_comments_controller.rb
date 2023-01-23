class Public::WhiskeyCommentsController < ApplicationController
  before_action :authenticate, only: [:user, :admin]
  before_action :ensure_user, only: [:destroy]

  def create
    @whiskey = Whiskey.find(params[:whiskey_id])
    #投稿に紐づいたコメントを作成
    @whiskey_comment = @whiskey.whiskey_comments.new(comment_params)
    # コメント投稿者(user)のidを代入
    @whiskey_comment.user_id = current_user.id
    @whiskey_comment.save
    @whiskey.create_notification_comment(current_user, @whiskey_comment.id)
    @comments = @whiskey.whiskey_comments.order('created_at DESC').page(params[:page]).per(4)
  end

  def destroy
    @whiskey = Whiskey.find(params[:whiskey_id])
    @whiskey_comment = WhiskeyComment.find(params[:id])
    @whiskey_comment.destroy
    @comments = @whiskey.whiskey_comments.order('created_at DESC').page(params[:page]).per(4)
  end

  private
    def comment_params
      params.require(:whiskey_comment).permit(:comment)
    end
    
    def ensure_user
      unless admin_signed_in?
        @comments = current_user.whiskey_comments
        @whiskey_comment = @comments.find_by(id: params[:id])
        redirect_to whiskeys_path unless @whiskey_comment
      end
    end

end
