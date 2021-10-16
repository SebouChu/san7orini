Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  delete '/users/auth/:provider/unlink',
    to: 'users/omniauth_callbacks#unlink',
    constraints: lambda { |request|
      request.env["devise.mapping"] = Devise.mappings[:user] &&
      Rails.application.config.devise.omniauth_providers.include?(request.params[:provider].to_sym)
    },
    as: :user_omniauth_unlink

  root 'home#index'
end
