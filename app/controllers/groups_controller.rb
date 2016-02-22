class GroupsController < ApplicationController

  def show

    # managesテーブルへの登録をここでしている
    @user_id = current_user.id
    @group_id = request.path_info.split("/")[2]

    Manage.find_or_create_by(user_id: @user_id, group_id: @group_id)

    @group_members = Manage.where("group_id  = #{@group_id}")

=begin
#Pusher用の記述
    Pusher.trigger('chat_event', 'my_event', {
message: params[:message]}
  )
=end

  end

  def new
    @group = Group.where('user_id : current_user.id').new
  end

  def create
    @group = Group.create(create_params)
    # managesテーブルにデータを格納
    Manage.create(user_id: current_user.id, group_id: @group.id)

    # フォームから得たアドレスを配列にして格納
    i = 1
    dest_ary = []
    invite_user = "invite_user#{i}"
#    binding.pry
    while params[:group]["#{invite_user}"] != "" do
      dest_ary << params[:group]["#{invite_user}"]
      i += 1
      invite_user = "invite_user#{i}"
    end
#    binding.pry


    # この瞬間に作成されたグループのURLをg_pageに代入
    #個々のグループページのviewファイル編集後にパスを指定
    g_page = "http://localhost:3000/groups/#{@group.id}"
    #編集が必要 "/groups/:id"
    # 引数：user, destination, g_page
    # 配列の要素数だけループ
    dest_ary.each { |destination|
      ShareMailer.send_to_share(current_user, destination, g_page).deliver
    }
  end

  def pushercreate

    Pusher['general_channel'].trigger('chat_event', {
      message: params[:message]
      })
      #render :text => 'OK', :status => 200 and return
      #ここまでならinternal server errorは発生しない


    redirect_to :action => 'show'
    # どうしても最後のこの部分でエラーが発生する
    # ActionController::UrlGenerationError (No route matches {:action=>"show", :controller=>"groups"}):
    # app/controllers/groups_controller.rb:58:in `pushercreate'


  end


  def edit
  end

  private
  # Rails4からStrongParamaterと呼ばれる機能が追加されました。
  # セキュリティのため、permitメソッドで許可したパラメータ名しか取得できません。
  def create_params
    @new_record = params.require(:group).permit(:group_name, :group_desc, :start_year, :start_month, :end_year, :check_span)
#    binding.pry
  end

end