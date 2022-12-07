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
    @price_ranges = price_ranges
  end

  def edit
    @whiskey = Whiskey.find(params[:id])
    @tag_list = @whiskey.tags.pluck(:tag).join(',')
    @price_ranges = price_ranges
  end

  def create
    @whiskey = Whiskey.new(whiskey_params)
    @whiskey.user_id = current_user.id
    @price_ranges = @whiskey.price_range
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
    @price_ranges = @whiskey.price_range
    if @whiskey.update(whiskey_params)
      # このwhiskey_idに紐づいていたタグを@old_relationsに入れる
      @old_relations = WhiskeyTag.where(whiskey_id: @whiskey.id)
      # それらを取り出して消す
      @old_relations.each do |relation|
        relation.delete
      end
      @whiskey.save_tag(tag_list)
      redirect_to whiskey_path(@whiskey)
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

  def price_ranges
    [["〜2000円","〜2000円"],["2000円〜4000円","2000円〜4000円"],["4000円〜6000円","4000円〜6000円"],["6000円〜8000円","6000円〜8000円"],["8000円〜10000円","8000円〜10000円"],["10000円〜","10000円〜"]]
  end

end
