class Public::WhiskeysController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @whiskeys = Whiskey.all.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
    @whiskey = Whiskey.find(params[:id])
    @whiskey_comment = WhiskeyComment.new
  end

  def new
    @whiskey = Whiskey.new
    @tag_list = Tag.new
  end

  def edit
    @whiskey = Whiskey.find(params[:id])
    @tag_list = @whiskey.tags.pluck(:tag).join(',')
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
      render "new"
    end
  end

  def update
    @whiskey = Whiskey.find(params[:id])
    tag_list = params[:whiskey][:tag].split(',')
    if @whiskey.update(whiskey_params)
      @whiskey.save_tag(tag_list)
      redirect_to whiskey_path(whiskey)
    else
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
