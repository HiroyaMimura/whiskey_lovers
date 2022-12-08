class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @whiskeys = Whiskey.all.page(params[:page]).per(10)
    @tag_list = Tag.all
  end
end
