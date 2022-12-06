class Public::WhiskeysController < ApplicationController
  before_action :authenticate_user!
  
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
    @whiskey = Whiskey.find(params[:id])
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
    @whiskey = Whiskey.find(params[:id])
    if @whiskey.update(whiskey_params)
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
