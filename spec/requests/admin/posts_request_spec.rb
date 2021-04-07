require 'rails_helper'

RSpec.describe 'Admin::Postsリクエストのテスト' , type: :request do
  let(:admin) { create(:admin) }
  let(:member) { create(:member) }
  let(:post) { create(:post, member_id: member.id) }

  describe '投稿一覧画面の表示' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get admin_posts_path
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in admin
        get admin_posts_path
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '投稿詳細画面の表示' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get admin_post_path post.id
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in admin
        get admin_post_path post.id
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '投稿の削除' do
    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in admin
        delete admin_post_path post.id
        expect(response).to have_http_status '302'
      end
    end
  end

end