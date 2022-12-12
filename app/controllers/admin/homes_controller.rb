class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @whiskeys = Whiskey.page(params[:page]).per(2)
    @tag_list = Tag.all
  end
end
