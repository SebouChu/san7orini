class AddFacebookOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :facebook_uid, :string
  end
end
