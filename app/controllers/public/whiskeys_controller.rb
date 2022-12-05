class Public::WhiskeysController < ApplicationController
  def index
    @whiskeys = Whiskey.all
  end

  def show
    @whiskey = Whiskey.find(params[:id])
    @whiskey_comment = WhiskeyComment.new
  end

  def new
    @whiskey = Whiskey.new
  end

  def edit
  end

  def create
    @whiskey = Whiskey.new(whiskey_params)
    @whiskey.user_id = current_user.id
    if @whiskey.save
      redirect_to whiskeys_path
    else
      render "new"
    end
  end

  def update
  end

  def destroy
  end

  private

  def whiskey_params
    params.require(:whiskey).permit(:name,:impression,:whiskey_image,:taste,:scent,:price_range,:performance)
  end

end
