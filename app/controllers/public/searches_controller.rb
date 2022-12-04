class Public::SearchesController < ApplicationController
  
  def index
    @range = params[:range]
    @word = params[:word]
    if @range == "Tag"
      @tags = Tag.looks(params[:word])
    else
      @whiskeys = Whiskey.looks(params[:word])
    end
    
    @price = params[:price]
    @price_range = Whiskey.looks(params[:price])
  end
end
