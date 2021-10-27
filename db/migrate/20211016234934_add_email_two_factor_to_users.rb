class AddEmailTwoFactorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :two_factor_email_enabled, :boolean, default: false
    add_column :users, :two_factor_email_verified, :boolean, default: false
  end
end
