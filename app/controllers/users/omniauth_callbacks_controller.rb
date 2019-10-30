# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env['omniauth.auth']
    user_params = {
      email: auth.info.email,
      provider: auth.provider,
      url: "https://facebook.com/?id=#{auth.extra.raw_info.id}"
    }

    @user = User.find_or_create_by_omniauth(user_params)

    if @user&.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Facebook',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  def vkontakte
    auth = request.env['omniauth.auth']
    user_params = {
      email: auth.info.email,
      provider: auth.provider,
      url: "https://vk.com/?id=#{auth.uid}"
    }

    @user = User.find_or_create_by_omniauth(user_params)
    if @user&.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Vkontakte')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Vkontakte',
        reason: 'authentication error'
      )
      redirect_to root_path
    end
  end
end
