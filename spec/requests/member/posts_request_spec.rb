require 'rails_helper'

RSpec.describe 'Member::Postsリクエストのテスト', type: :request do
  let(:member) { create(:member) }
  let(:other_member) { create(:member) }
  let(:post) { create(:post, member_id: member.id) }

  describe '投稿新規登録画面の表示(GET #new)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get new_post_path
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        get new_post_path
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '投稿一覧画面の表示(GET #index)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get posts_path
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        get posts_path
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '投稿詳細画面の表示(GET #show)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get post_path post.id
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        get post_path post.id
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '投稿編集画面の表示(GET #edit)' do
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトすること' do
        get edit_post_path post.id
        expect(response).to redirect_to new_member_session_path
      end
    end

    context 'ログインしている場合' do
      context '投稿者がログインしている場合' do
        it 'リクエストが成功すること' do
          sign_in member
          get edit_post_path post.id
          expect(response).to have_http_status '200'
        end
      end
      context '投稿者以外がログインしている場合' do
        it '投稿一覧に遷移すること' do
          sign_in other_member
          get edit_post_path post.id
          expect(response).to redirect_to posts_path
        end
      end
    end
  end

  describe '投稿の削除(DELETE #destroy)' do
    context '投稿者がログインしている場合' do
      it 'リクエストが成功すること' do
        sign_in member
        delete post_path post.id
        expect(response).to have_http_status '302'
      end
    end
  end
end
