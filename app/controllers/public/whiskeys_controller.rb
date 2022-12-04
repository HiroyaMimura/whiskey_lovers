class Public::WhiskeysController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @whiskey = Whiskey.new(whiskey_params)
    @whiskey.user_id = current_user.id
    if @whiskey.save
      redirect_to whiskeys_path
    else
      flash[:notice] = "全て入力してください"
      redirect_to new_whiskey_path
    end
  end

  def update
  end

  def destroy
  end

  private

  def whiskey_params
    params.require(:whiskey).permit(:name,:impression,:whiskey_image,:performance)
  end

end
