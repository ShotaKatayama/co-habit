class ContinuesController < ApplicationController

  def index
  end

  def create
    def check_habit(user_id, group_id)
      group_num = Manage.where(user_id: user_id, group_id: group_id)[0].group_num
      Continue.create(user_id: user_id, group_id: group_id, created_day: Date.today, group_num: group_num)
    end
    redirect_to :root
  end

end
