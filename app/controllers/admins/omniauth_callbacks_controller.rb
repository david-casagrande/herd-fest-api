module Admins
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @admin = Admin.from_omniauth(request.env['omniauth.auth'])

      if @admin
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success'
        sign_in_and_redirect @admin, event: :authentication
      else
        flash[:error] = I18n.t 'devise.omniauth_callbacks.failure'
        redirect_to new_admin_session_path
      end
    end
  end
end
