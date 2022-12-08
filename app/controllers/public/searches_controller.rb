class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def searches_name
    @word = params[:word]
    if @word.blank?
      redirect_to whiskeys_path
    else
      @whiskeys_search = Whiskey.search(params[:word])
    end
  end

  def searches_price
    @word = params[:price]
    @whiskeys_search = Whiskey.looks(params[:price])
  end

  def searches_tag
    @tag = Tag.find(params[:tag_id])
    @word = @tag.tag
    @whiskeys_search = @tag.whiskeys
  end
end
