class CreateFollowJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.integer 'following_id', :null => false, index: true
      t.integer 'follower_id', :null => false, index: true

      t.timestamps null: false
    end

    add_index :follows, [:following_id, :follower_id], unique: true
  end
end
