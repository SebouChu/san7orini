class AddGoogleOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :google_oauth2_uid, :string
  end
end
