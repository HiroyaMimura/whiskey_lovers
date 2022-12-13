class Public::WhiskeyCommentsController < ApplicationController
  before_action :authenticate, only: [:user, :admin]

  def create
    @whiskey = Whiskey.find(params[:whiskey_id])
    #投稿に紐づいたコメントを作成
    @whiskey_comment = @whiskey.whiskey_comments.new(comment_params)
    # コメント投稿者(user)のidを代入
    @whiskey_comment.user_id = current_user.id
    @whiskey_comment.save
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

end
