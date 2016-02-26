module ApplicationHelper

  def check_habit(user_id, group_id)
    Continue.create(user_id: user_id, group_id: group_id)
  end

end
