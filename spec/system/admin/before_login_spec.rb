require 'rails_helper'

RSpec.describe '管理者ログイン前のテスト', type: :system do
  let(:admin) { create(:admin) }

  describe '管理者ログインのテスト' do
    before do
      visit new_admin_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admins/sign_in'
      end
      it 'Emailフォームが表示される' do
        expect(page).to have_field 'admin[email]'
      end
      it 'Passwordフォームが表示される' do
        expect(page).to have_field 'admin[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が投稿一覧である' do
        expect(current_path).to eq admin_posts_path
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトする' do
        expect(current_path).to eq new_admin_session_path
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'Log in'
    end

    context '表示内容の確認' do
      it 'postsリンクが表示される' do
        expect(page).to have_link 'posts', href: admin_posts_path
      end
      it 'usersリンクが表示される' do
        expect(page).to have_link 'users', href: admin_members_path
      end
      it 'log outリンクが表示される' do
        expect(page).to have_link 'log out', href: destroy_admin_session_path
      end
    end
  end

  describe '管理者ログアウトのテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'Log in'
      click_on 'log out'
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先がトップページである' do
        expect(current_path).to eq root_path
      end
    end
  end
end
