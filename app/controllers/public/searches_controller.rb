class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def searches_name
    @word = params[:word]
    @tag_list = Tag.all
    if @word.blank?
      redirect_to whiskeys_path
    else
      @whiskeys_search = Whiskey.search(@word).order('created_at DESC').page(params[:page]).per(5)
    end
  end

  def searches_price
    @word = params[:price]
    @tag_list = Tag.all
    if @word.blank?
      redirect_to whiskeys_path
    else
      @whiskeys_search = Whiskey.looks(@word).order('created_at DESC').page(params[:page]).per(5)
    end
  end

  def searches_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @word = @tag.tag
    @whiskeys_search = @tag.whiskeys.order('created_at DESC').page(params[:page]).per(5)
  end
end
