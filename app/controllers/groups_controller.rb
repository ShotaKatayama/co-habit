class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(create_params)
    unless @group.save
      # ValidationエラーなどでDBに保存できない場合 new.html.erb を再表示
      render 'new'
    end

    # フォームから得たアドレスを配列にして格納
    i = 1
    dest_ary = []
    invite_user = "invite_user#{i}"
    while params[:group]["#{invite_user}"] != nil do
      dest_ary << params[:group]["#{invite_user}"]
      i++
      invite_user = "invite_user#{i}"
    end

    binding.pry


=begin
    # この瞬間に作成されたグループのURLをg_pageに代入
    g_page = #個々のグループページのviewファイル編集後にパスを指定
    # 引数：user, destination, g_page
    # 配列の要素数だけループ
    dest_ary.each { |destination|
      ShareMailer.send_to_share(current_user, destination g_page).deliver
    }
=end
  end

=begin
      ※createメソッド用のメモ
      ※入力されたparamsの中身
      <!-- binding.pryの結果
      [2] pry(#<#<Class:0x007fcce7de08f8>>)> params
      => {"utf8"=>"✓",
       "authenticity_token"=>
        "obtUfOfUdaMRHu2m7g1SwNQ0WRD9UxkFCAMmDIf7ZKc6kdZlbBWlgBJyGQe2fV65H+qkx1bpzGZym+TM9YVqsA==",
       "group"=>
        {"group_name"=>"aaa",
         "group_desc"=>"aaa",
         "start_year"=>"2016-01-18",
         "end_year"=>"2016-01-27"},
       "commit"=>"送信",
       "controller"=>"groups",
       "action"=>"create"} -->
=end

  def edit
  end

  private
  # Rails4からStrongParamaterと呼ばれる機能が追加されました。
  # セキュリティのため、permitメソッドで許可したパラメータ名しか取得できません。
  def create_params
    params.require(:group).permit(:group_name, :group_desc, :start_year, :start_month, :end_year, :check_span)
  end

end