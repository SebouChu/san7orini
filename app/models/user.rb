# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  facebook_uid           :string
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  github_uid             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  twitter_uid            :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  devise  :database_authenticatable, :registerable, :recoverable,
          :rememberable, :validatable, :confirmable, :lockable, :timeoutable,
          :trackable, :omniauthable, omniauth_providers: %i[facebook github twitter]

  def self.from_omniauth(auth)
    provider = auth.provider
    u = where(email: auth.info.email).first_or_create do
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
    u.update("#{provider}_uid" => auth.uid)
    u
  end

  def to_s
    full_name.present? ? full_name : email
  end

  def full_name
    @full_name ||= "#{first_name} #{last_name}".strip
  end
end
