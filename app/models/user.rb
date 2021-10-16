# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
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
          :trackable, :omniauthable, omniauth_providers: Rails.application.config.devise.omniauth_providers

  has_many :identities, class_name: 'User::Identity', dependent: :destroy

  def self.from_omniauth(auth, signed_id_user = nil)
    identity = User::Identity.from_omniauth(auth)
    user = signed_id_user
    user ||= identity.user
    user ||= where(email: auth.info.email).first_or_create do
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end

    identity.user = user
    identity.save
    user
  end

  def to_s
    full_name.present? ? full_name : email
  end

  def full_name
    @full_name ||= "#{first_name} #{last_name}".strip
  end
end
