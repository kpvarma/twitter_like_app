class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.integer :tweet_id
      t.integer :user_id
      t.timestamp :created_at
    end
    
    add_index :retweets, [:user_id, :tweet_id] 
    
  end
end
