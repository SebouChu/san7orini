# == Schema Information
#
# Table name: users
#
#  id                            :uuid             not null, primary key
#  confirmation_sent_at          :datetime
#  confirmation_token            :string
#  confirmed_at                  :datetime
#  current_sign_in_at            :datetime
#  current_sign_in_ip            :string
#  direct_otp                    :string
#  direct_otp_sent_at            :datetime
#  email                         :string           default(""), not null
#  encrypted_otp_secret_key      :string
#  encrypted_otp_secret_key_iv   :string
#  encrypted_otp_secret_key_salt :string
#  encrypted_password            :string           default(""), not null
#  failed_attempts               :integer          default(0), not null
#  first_name                    :string
#  last_name                     :string
#  last_sign_in_at               :datetime
#  last_sign_in_ip               :string
#  locked_at                     :datetime
#  remember_created_at           :datetime
#  reset_password_sent_at        :datetime
#  reset_password_token          :string
#  second_factor_attempts_count  :integer          default(0)
#  sign_in_count                 :integer          default(0), not null
#  totp_timestamp                :datetime
#  two_factor_email_enabled      :boolean          default(FALSE)
#  two_factor_email_verified     :boolean          default(FALSE)
#  unconfirmed_email             :string
#  unlock_token                  :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token        (confirmation_token) UNIQUE
#  index_users_on_email                     (email) UNIQUE
#  index_users_on_encrypted_otp_secret_key  (encrypted_otp_secret_key) UNIQUE
#  index_users_on_reset_password_token      (reset_password_token) UNIQUE
#  index_users_on_unlock_token              (unlock_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
