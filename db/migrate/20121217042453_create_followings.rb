class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :follower_id
      t.timestamp :subscribed_at
    end
    
    add_index :followings, [:user_id, :follower_id] 
    
  end
end
