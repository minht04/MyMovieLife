require 'rails_helper'

RSpec.describe 'Admin::Membersリクエストのテスト', type: :request do
  let(:admin) { create(:admin) }
  let(:member) { create(:member) }

  describe 'ユーザー一覧画面の表示(GET #index)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get admin_members_path
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in admin
        get admin_members_path
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'ユーザー詳細画面の表示(GET #show)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get admin_member_path member.id
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in admin
        get admin_member_path member.id
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'ユーザー編集画面の表示(GET #edit)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get edit_admin_member_path member.id
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in admin
        get edit_admin_member_path member.id
        expect(response).to have_http_status '200'
      end
    end
  end
end
