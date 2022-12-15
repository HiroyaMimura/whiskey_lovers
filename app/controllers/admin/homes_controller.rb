class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @whiskeys = Whiskey.order('created_at DESC').page(params[:page]).per(5)
    @tag_list = Tag.all
  end
end
