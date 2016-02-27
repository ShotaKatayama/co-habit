class GroupsController < ApplicationController

  def show
    # managesテーブルへの登録をここでしている
    @user_id = current_user.id
    @group_id = request.path_info.split("/")[2]
    @g_num = Manage.where($g_g_num).order("group_num").last[:group_num]

    Manage.find_or_create_by(user_id: @user_id, group_id: @group_id, group_num: @g_num.to_i+1)

    @group_members = Manage.where("group_id  = #{@group_id}")


    @color_array = ["red", "blue", "green", "yellow", "pink", "purple"]
    gon.color_array = @color_array

    gon.user_color_index = Manage.where("user_id = #{current_user.id}").where("group_id = #{@group_id}")[0].group_num-1

    # 該当するグループのdropsテーブルに名前があるユーザーの情報の配列
    @drop_users = Drop.where(group_id: @group_id)

    # create_color_date()はuser_idとgroup_idを入れたら日付と色識別番号が配列で返ってくるメソッド
    @color_date = []
    @group_members.each{|member|
        @color_date << create_color_date(member.user_id, member.group_id)
    }
    # この結果、color_dateは二重配列
    gon.color_date = @color_date

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
    Manage.create(user_id: current_user.id, group_id: @group.id, group_num: 1)

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

    g_page = "https://co-habit.herokuapp.com/groups/#{@group.id}"
    #編集が必要 "/groups/:id"
    # 引数：user, destination, g_page
    # 配列の要素数だけループ
    dest_ary.each { |destination|
      ShareMailer.send_to_share(current_user, destination, g_page).deliver
    }
    redirect_to :root
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
    @group = Group.find(params[:id])
    @group_info = Group.where(id: params[:id])
  end

  def update
    Group.find(params[:id]).update(update_params)
    redirect_to :root
  end

  def destroy
    group = Group.find(params[:id])
    #continues
    Continue.where(group_id: group.id).each{|continue|
      continue.destroy
    }
    #drops
    Drop.where(group_id: group.id).each{|drop|
      drop.destroy
    }
    #manages
    Manage.where(group_id: group.id).each{|manage|
      manage.destroy
    }
    group.destroy
    redirect_to :root
  end

  private
  # Rails4からStrongParamaterと呼ばれる機能が追加されました。
  # セキュリティのため、permitメソッドで許可したパラメータ名しか取得できません。
  def create_params
    @new_record = params.require(:group).permit(:group_name, :group_desc, :start_year, :start_month, :end_year, :check_span, :check_span_counter)
  end

  def update_params
    params.require(:group).permit(:group_name, :group_desc, :start_year, :end_year, :check_span, :check_span_counter)
  end

  def color_index_create(user_id, group_id)
    color_index = Manage.where(user_id: user_id, group_id: group_id)[0].group_num
    return color_index
  end

  def continue_date_create(user_id, group_id)
    continue_date = Continue.where(user_id: user_id, group_id: group_id)[0].created_at.to_date
    return continue_date
  end

  def create_color_date(user_id, group_id)
    # ハッシュ版
    # color_date_set = {:"#{continue_date_create(user_id, group_id)}" => color_index_create(user_id, group_id)}

    # 配列版 インデックス:0が日付、:1が色の識別番号
    color_date_set =[]
    unless Continue.where(user_id: user_id, group_id: group_id).empty?
      color_date_set << continue_date_create(user_id, group_id)
      color_date_set << color_index_create(user_id, group_id)
    end

    # 配列を返り値とする
    return color_date_set
  end
end