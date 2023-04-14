class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followee_id
      t.index [:followee_id, :follower_id], unique: true
      t.timestamps
    end
  end
end
