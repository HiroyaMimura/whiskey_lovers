class Public::WhiskeysController < ApplicationController
  before_action :authenticate_user!

  def index
    @whiskeys = Whiskey.order('created_at DESC').page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def show
    @whiskey = Whiskey.find(params[:id])
    @whiskey_comment = WhiskeyComment.new
    @comments = @whiskey.whiskey_comments.order('created_at DESC').page(params[:page]).per(4)
  end

  def new
    @whiskey = Whiskey.new
    @tag_list = Tag.new
    @tag = Tag.all
  end

  def edit
    @whiskey = Whiskey.find(params[:id])
    @tag_list = @whiskey.tags.pluck(:tag).join(',')
    @tag = Tag.all
    unless @whiskey.user_id == current_user.id
      flash[:notice] = "他の方の投稿は編集できません"
      redirect_to whiskeys_path
    end
  end

  def create
    @whiskey = Whiskey.new(whiskey_params)
    @whiskey.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:whiskey][:tag].split(',')
    if @whiskey.save
       @whiskey.save_tag(tag_list)
       redirect_to whiskeys_path
    else
      @tag = Tag.all
      render "new"
    end
  end

  def update
    @whiskey = Whiskey.find(params[:id])
    tag_list = params[:whiskey][:tag].split(',')
    if @whiskey.update(whiskey_params)
      # このwhiskey_idに紐づいていたタグをold_relationsに入れる
      old_relations = WhiskeyTag.where(whiskey_id: @whiskey.id)
      # それらを取り出して消す
      old_relations.each do |relation|
        relation.delete
      end
      @whiskey.save_tag(tag_list)
      redirect_to whiskey_path(@whiskey)
    else
      @tag = Tag.all
      render "edit"
    end
  end

  def destroy
    @whiskey = Whiskey.find(params[:id])
    @whiskey.destroy
    redirect_to whiskeys_path
  end

  private

  def whiskey_params
    params.require(:whiskey).permit(:name,:impression,:whiskey_image,:taste,:scent,:price_range,:performance)
  end

end
