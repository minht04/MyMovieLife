require 'rails_helper'

RSpec.describe 'ユーザーログイン前のテスト', type: :system do
  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'homeリンクが表示される' do
        expect(page).to have_link 'home', href: root_path
      end
      it 'aboutリンクが表示される' do
        expect(page).to have_link 'about', href: home_about_path
      end
      it 'sign upリンクが表示される' do
        expect(page).to have_link 'sign up', href: new_member_registration_path
      end
      it 'sign inリンクが表示される' do
        expect(page).to have_link 'log in', href: new_member_session_path
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_member_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/members/sign_up'
      end
      it 'Nameフォームが表示される' do
        expect(page).to have_field 'member[name]'
      end
      it 'Emailフォームが表示される' do
        expect(page).to have_field 'member[email]'
      end
      it 'Passwordフォームが表示される' do
        expect(page).to have_field 'member[password]'
      end
      it 'Password confirmationフォームが表示される' do
        expect(page).to have_field 'member[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'member[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'member[email]', with: Faker::Internet.email
        fill_in 'member[password]', with: 'password'
        fill_in 'member[password_confirmation]', with: 'password'
      end

      it '正しく登録される' do
        expect { click_button 'Sign up' }.to change(Member.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が投稿一覧である' do
        click_button 'Sign up'
        expect(current_path).to eq posts_path
      end
    end
  end

  describe 'ユーザーログインのテスト' do
    let(:member) { create(:member) }

    before do
      visit new_member_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/members/sign_in'
      end
      it 'Emailフォームが表示される' do
        expect(page).to have_field 'member[email]'
      end
      it 'Passwordフォームが表示される' do
        expect(page).to have_field 'member[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'member[email]', with: member.email
        fill_in 'member[password]', with: member.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が投稿一覧である' do
        expect(current_path).to eq posts_path
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'member[email]', with: ''
        fill_in 'member[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトする' do
        expect(current_path).to eq new_member_session_path
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:member) { create(:member) }

    before do
      visit new_member_session_path
      fill_in 'member[email]', with: member.email
      fill_in 'member[password]', with: member.password
      click_button 'Log in'
    end

    context '表示内容の確認' do
      it 'my pageリンクが表示される' do
        expect(page).to have_link 'my page', href: member_path(member)
      end
      it 'time lineリンクが表示される' do
        expect(page).to have_link 'time line', href: timeline_member_path(member)
      end
      it 'postsリンクが表示される' do
        expect(page).to have_link 'posts', href: posts_path
      end
      it 'usersリンクが表示される' do
        expect(page).to have_link 'users', href: members_path
      end
      it 'notificationリンクが表示される' do
        expect(page).to have_link 'notification', href: member_notifications_path(member)
      end
      it 'log outリンクが表示される' do
        expect(page).to have_link 'log out', href: destroy_member_session_path
      end
    end
  end

  describe 'ユーザーログアウトのテスト' do
    let(:member) { create(:member) }

    before do
      visit new_member_session_path
      fill_in 'member[email]', with: member.email
      fill_in 'member[password]', with: member.password
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