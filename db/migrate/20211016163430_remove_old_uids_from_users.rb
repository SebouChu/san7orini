class RemoveOldUidsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :facebook_uid, :string
    remove_column :users, :github_uid, :string
    remove_column :users, :google_oauth2_uid, :string
    remove_column :users, :twitter_uid, :string
  end
end
