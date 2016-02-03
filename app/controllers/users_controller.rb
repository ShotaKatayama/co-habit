class UsersController < ApplicationController

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
    @i = 0
#    binding.pry

    #@group_datumの中はGroupモデルのインスタンスにする

  end

end
