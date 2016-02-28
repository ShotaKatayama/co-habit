class Group < ActiveRecord::Base
  has_many :manages
  has_many :users, through: :manages

  has_many :continues
  has_many :drops



  validates :group_name, presence:  true
  validates :start_year, presence:  true
  validates :end_year, presence:  true

  validates :check_span, presence:  true

  validates :check_span_counter, presence:  true


  #accessor
  attr_accessor :invite_user1,
                :invite_user2,
                :invite_user3,
                :invite_user4,
                :invite_user5

end
