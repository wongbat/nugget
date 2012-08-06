class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id

  belongs_to :user
  validates :user, :presence => true
  validates :content, :length => { :maximum => 140 }
end
