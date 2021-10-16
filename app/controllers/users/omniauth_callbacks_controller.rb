# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback(:facebook)
  end

  def github
    callback(:github)
  end

  def google_oauth2
    callback(:google_oauth2)
  end

  def twitter
    callback(:twitter)
  end

  def failure
    redirect_to root_path
  end

  def unlink
    provider = params[:provider]
    current_user.identities.find_by(provider: provider)&.destroy
    redirect_to edit_user_registration_path(anchor: 'identities'), notice: "#{provider.to_s.capitalize} account was successfully unlinked."
  end

  protected

  def callback(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      if user_signed_in?
        redirect_to request.env['omniauth.origin'],
                    notice: "#{provider.to_s.capitalize} account successfully linked."
      else
        sign_in_and_redirect(@user, event: :authentication)
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      end
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end
end
