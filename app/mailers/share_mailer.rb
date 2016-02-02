class ShareMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.share_mailer.send_to_share.subject
  #
  def send_to_share(user, destination, g_page)
    # グループを作成したユーザー
    @user = user
    # 招待されたユーザーのアドレス
    @dest = destination
    # 招待されたグループページのURL
    @g_page = g_page

    #to: のところに
    #フォームで得たアドレスを投入
    #ハッシュで得た値を配列化して、繰り返し処理
    mail  to: "#{@dest}",
          subject: "#{@user.name}さんからグループの招待が届きました"
  end
end
