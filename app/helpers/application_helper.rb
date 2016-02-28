module ApplicationHelper

  def check_habit(user_id, group_id)
    Continue.create(user_id: user_id, group_id: group_id, created_day: Date.today)
  end

  # 習慣の未実施回数の算出
  # 数えたいユーザーのidとそのグループidのdropsテーブルに存在するユーザーの一覧を引数とする
  def count_drop(user_id, drop_info_in_group)
      counter = 0
      drop_info_in_group.each{|drop|
        if drop.user_id != nil
          if drop.user_id == user_id
            counter += 1
          end
        end
      }
      return counter
  end
end
