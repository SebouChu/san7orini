class AddTwitterOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :twitter_uid, :string
  end
end
