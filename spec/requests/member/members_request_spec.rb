require 'rails_helper'

RSpec.describe 'Members', type: :request do
  let(:member) { create(:member) }
  let(:other_member) { create(:member) }

  describe 'ユーザー一覧画面の表示' do
    context 'ログインしていない場合' do
      it "ログインページへリダイレクトすること" do
        get members_path
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        get members_path
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'ユーザー詳細画面の表示' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get member_path member.id
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        get member_path member.id
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'ユーザー編集画面の表示' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get edit_member_path member.id
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      context '本人がログインしている場合' do
        it 'リクエストが成功すること' do
          sign_in member
          get edit_member_path member.id
          expect(response).to have_http_status '200'
        end
      end
      context '本人以外がログインしている場合' do
        it 'ログインユーザーの詳細画面に遷移すること' do
          sign_in other_member
          get edit_member_path member.id
          expect(response).to redirect_to member_path other_member.id
        end
      end
    end
  end

end