require 'rails_helper'

RSpec.describe 'Member::Notificationsリクエストのテスト', type: :request do
  let(:member) { create(:member) }

  describe '通知一覧画面の表示' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get member_notifications_path member.id
        expect(response).to redirect_to new_member_session_path
      end
    end
    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        get member_notifications_path member.id
        expect(response).to have_http_status '200'
      end
    end
  end

end