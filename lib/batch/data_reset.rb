class Batch::DataReset
  def self.data_reset
    # ゲストユーザの投稿など全て削除
    user = User.find_by(email: "guest@example.com")
    user.whiskeys.destroy_all
    user.whiskey_comments.destroy_all
    user.favorites.destroy_all
    p "投稿を全て削除しました"
  end
end