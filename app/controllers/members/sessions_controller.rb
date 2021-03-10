# frozen_string_literal: true

class Members::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_member, only: [:create]

  def new_guest
    member = Member.guest
    sign_in member
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました！'
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def reject_member   # 削除済みユーザーをログインさせない
    @member = Member.find_by(email: params[:member][:email].downcase)
    if @member
      if (@member.valid_password?(params[:member][:password]) && (@member.active_for_authentication? == false))
        flash[:alert] = "アカウントは削除されています。"
        redirect_to new_member_session_path
      end
    else
      flash[:alert] = "必須項目を入力してください。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
