class Following < ActiveRecord::Base
  
  validates :follower_id, :presence=>true
  validates :user_id, :presence=>true
  
  belongs_to :user
  belongs_to :follower, :foreign_key=>:follower_id, :class_name=>'User'
  
end
