# frozen_string_literal: true

class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    # 'request.env['omniauth.auth']'の中にgoogleアカウントから取得したメールアドレスや名前といったデータが含まれている
    @omniauth = request.env['omniauth.auth']
    info = Member.find_oauth(@omniauth) # 'find_oauth'はmember.rbで定義
    @member = info[:member]    #  deviseのヘルパーを使うため@memberに代入
    if @member.persisted?      #  ユーザー登録済み（ログイン処理）
      sign_in_and_redirect @member, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      @sns = info[:sns]     # 取得した認証データを一時的に保持（ユーザー登録ページに渡す）
      render template: 'members/registrations/new'
    end
  end

  def failure
    redirect_to root_path and return
  end
end
