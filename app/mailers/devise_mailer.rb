class DeviseMailer < Devise::Mailer
  def two_factor_authentication_code(record, code, opts = {})
    @code = code
    devise_mail(record, :two_factor_authentication_code, opts)
  end
end
