class CreateSleepLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :sleep_logs do |t|
      t.references :user, index: true
      t.float :sleep_time
      t.datetime :wakeup_at
      t.timestamps
      t.index [:created_at, :user_id], unique: true
    end
  end
end
