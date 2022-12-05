class Public::WhiskeyCommentsController < ApplicationController

  def create
    @whiskey = Whiskey.find(params[:whiskey_id])
    #投稿に紐づいたコメントを作成
    @whiskey_comment = @whiskey.whiskey_comments.new(comment_params)
    # コメント投稿者(user)のidを代入
    @whiskey_comment.user_id = current_user.id
    @whiskey_comment.save
    render "public/whiskey_comments/create"
  end

  def destroy
    @whiskey = Whiskey.find(params[:whiskey_id])
    @whiskey_comment = WhiskeyComment.find(params[:id])
    @whiskey_comment.destroy
    render "public/whiskey_comments/destroy"
  end

  private
    def comment_params
      params.require(:whiskey_comment).permit(:comment, :user_id, :whiskey_id)
    end

end
