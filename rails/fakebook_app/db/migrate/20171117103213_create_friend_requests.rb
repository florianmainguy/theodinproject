class CreateFriendRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_requests do |t|
      t.references :user, foreign_key: true
      t.references :friend, index: true

      t.timestamps
    end
  end
end
