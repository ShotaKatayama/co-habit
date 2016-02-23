class Group < ActiveRecord::Base
  has_many :manages
  has_many :users, through: :manages

  has_many :continues
  has_many :drops

  #accessor
  attr_accessor :invite_user1,
                :invite_user2,
                :invite_user3,
                :invite_user4,
                :invite_user5,
                :invite_user6,
                :invite_user7,
                :invite_user8,
                :invite_user9,
                :invite_user10
end
