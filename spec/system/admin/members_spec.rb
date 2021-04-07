require 'rails_helper'

RSpec.describe 'Admin::Membersコントローラーのテスト', type: :system do
  let!(:admin) { create(:admin) }
  let!(:member) { create(:member) }
  let!(:post) { create(:post, member_id: member.id) }

  before do
    sign_in admin
  end

  describe 'ユーザー一覧画面のテスト' do
    before do
      visit admin_members_path
    end

    context '表示の確認' do
      it 'ユーザーのIDが表示されているか' do
        expect(page).to have_content member.id
      end
      it 'ユーザーの名前が表示されているか' do
        expect(page).to have_content member.name
      end
      it 'ユーザーのメールアドレスが表示されているか' do
        expect(page).to have_content member.email
      end
      it 'ユーザー詳細画面のリンクが存在するか' do
        expect(page).to have_link '', href: admin_member_path(member)
      end
    end
  end

  describe 'ユーザー詳細画面のテスト' do
    before do
      visit admin_member_path(member)
    end

    context '表示の確認' do
      it 'ユーザーのIDが表示されているか' do
        expect(page).to have_content member.id
      end
      it 'ユーザーの名前が表示されているか' do
        expect(page).to have_content member.name
      end
      it 'ユーザーのメールアドレスが表示されているか' do
        expect(page).to have_content member.email
      end
      it 'ユーザー編集画面のリンクが表示されているか' do
        expect(page).to have_link '', href: edit_admin_member_path(member)
      end
      it '投稿一覧にユーザーの投稿のタイトルが表示されているか' do
        expect(page).to have_content post.movie
      end
    end
  end

end