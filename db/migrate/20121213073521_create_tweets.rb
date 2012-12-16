class CreateTweets < ActiveRecord::Migration
  def change
    create_table(:tweets) do |t|
      
      t.integer :user_id, :null => false
      t.string :message, :null => false, :limit => 160
      t.boolean   :private, :default => false
      t.timestamps
      
    end

    add_index :tweets, :user_id
    add_index :tweets, :private
  end
end
