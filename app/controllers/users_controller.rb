class UsersController < ApplicationController

    before_action :check_groups, only: :show

  def show
    #Groupモデルを使用することに対してエラー発生
    @datum = Manage.where(user_id: current_user.id)
    # これは配列
    # @datum[0].user_id
    # で一番最初のインスタンスのuser_idを取得

    #@group_datumをインスタンスが入った配列にすれば良い？
=begin
    @group_datum = []
    @group_datum << Group.where(id: @datum.[0][:group_id])
=end


    @group_datum = []

    @datum.each{ |date|
      @group_datum << Group.where(id: date.group_id)[0]
    }
    #@group_datumの中はGroupモデルのインスタンスにする

  end

  private
  def check_groups
    #この関数で定時処理を行う
#    Time.now
#これで現在時刻を取得
  end

end
