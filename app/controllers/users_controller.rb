class UsersController < ApplicationController

#    before_action :check_groups, only: :show

  def show
    check_groups(current_user.id)


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
  def check_groups(user_id)
    #配列にログインユーザーが所属するグループのインスタンスを格納
    attend_groups = Manage.where(user_id: user_id)
    var_dumm1 = []
    attend_groups.each{ |date|
      var_dumm1 << date.group_id
    }
    var_dumm2 = []
    var_dumm1.each{ |date|
      var_dumm2 << Group.where(id: date)
    }

    #var_dumm2に格納されているグループのインスタンスごとに処理を実行
    var_dumm2.each{ |date, i|
      if date.last_check_day != Date.today
        # 新規グループか既存グループか
        if date.last_check_day == nil #初めてcheckを通るグループ
          last_day = date.start_year
          past_days = count_days(last_day)

          if past_days < 0
            # 習慣の始まりが将来及び今日の場合、処理は実行されない
          elsif past_days > 0
            # 数日経過している場合
            update_check_span_counter(date, past_days)
            last_check_stamp(date)
          else
            last_check_stamp(date)
          end
        else #checkが通るのが複数回目
          last_day = date.last_check_day
          past_days = count_days(last_day)
          update_check_span_counter(date, past_days)
          last_check_stamp(date)
        end
      end
    }
  end

  # グループのチェック︎履歴を更新
  def last_check_stamp(date)
    date.update_attribute(:last_check_day, Date.today)
  end

  # 経過日数の算出count_days
  def count_days(last_day)
    past_days = Date.today - last_day
    return past_days
  end

  # 更新update_check_span_counter
  def update_check_span_counter(g_instance, days)
    i = g_instance.check_span_counter
    while days > 0
      i -= 1
      g_instance.update_attribute(:check_span_counter, i)
      if i == 0
        add_drops_t(g_instance)
        g_instance.update_attribute(:check_span_counter, g_instance.check_span)
        i = g_instance.check_span
      end
      days -= 1
    end
  end

  # 判定日であるグループのインスタンスを受けとり、dropsテーブルを操作
  def add_drops_t(g_instance)
    # グループに参加しているユーザーの一覧の配列
    manages_ary = []
    Manage.where(group_id: g_instance.id).each{|date_for_manages_ary|
        manages_ary << {:user_id => date_for_manages_ary.user_id, :group_id => date_for_manages_ary.group_id}
      }

    # グループに参加していて、かつcontinuesテーブルに登録のあるユーザーの配列
    continues_ary = []
    check_day = g_instance.last_check_day + g_instance.check_span
    Continue.where(group_id: g_instance.id, created_at: g_instance.last_check_day...check_day).each{|date_for_continues_ary|
        continues_ary << {:user_id => date_for_continues_ary.user_id, :group_id => date_for_continues_ary.group_id}
      }

    # グループ全体の参加者リストとcontinueテーブルの参加者リストの比較
     drops_list = manages_ary - continues_ary

    # dropsテーブルへの追加メソッド
    # 差分をdropsテーブルに追加
     drops_list.each{|drop_mem|
      Drop.create(user_id: drop_mem[:user_id], group_id: drop_mem[:group_id])
     }

    #continuesテーブルにあるユーザーを削除
    #カレンダーに名前を出したかったら削除しないほうが良い
    #その場合、主な管理はcreated_atの日付で管理
  end

end
