require 'rails_helper'

RSpec.describe 'Membersコントローラーのテスト', type: :system do
  let!(:member) { create(:member) }
  let!(:other_member) { create(:member) }
  let!(:post) { create(:post, member_id: member.id) }
  let!(:other_post) { create(:post, member_id: other_member.id) }

  before do
    sign_in member
  end

  describe 'ユーザー一覧のテスト' do
    before do
      visit members_path
    end

    context '表示の確認' do
      it 'ユーザーの名前が表示されているか' do
        expect(page).to have_content member.name
        expect(page).to have_content other_member.name
      end
      it 'ユーザー詳細画面のリンクが存在するか' do
        expect(page).to have_link '', href: member_path(member)
        expect(page).to have_link '', href: member_path(other_member)
      end
    end
  end

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit member_path(member)
    end

    context '表示の確認' do
      it '自分の名前が表示されているか' do
        expect(page).to have_content member.name
      end
      it '自分の自己紹介文が表示されているか' do
        expect(page).to have_content member.introduction
      end
      it 'プロフィール編集画面のリンクが表示されてるか' do
        expect(page).to have_link '', href: edit_member_path(member)
      end
      it '投稿一覧に自分の投稿のタイトルが表示されている' do
        expect(page).to have_content post.movie
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_content other_post.movie
      end
    end
  end

  describe '自分のプロフィール編集画面のテスト' do
    before do
      visit edit_member_path(member)
    end

    context '表示の確認' do
      it '編集前の自分の名前が表示されている' do
        expect(page).to have_field 'member[name]', with: member.name
      end
      it 'Imageフォームが表示されている' do
        expect(page).to have_field 'member[profile_image]'
      end
      it 'Introductionフォームが表示されている' do
        expect(page).to have_field 'member[introduction]', with: member.introduction
      end
      it '保存ボタンが表示されている' do
        expect(page).to have_button 'Update Profile'
      end
    end
    
    context 'プロフィール更新処理のテスト' do
      before do
        @member_old_name = member.name
        @member_old_introduction = member.introduction
        fill_in 'member[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'member[introduction]', with: Faker::Lorem.characters(number: 10)
        click_button 'Update Profile'
      end
      it 'nameが正しく更新される' do
        expect(member.reload.name).not_to eq @member_old_name
      end
      it 'introductionが正しく更新される' do
        expect(member.reload.introduction).not_to eq @member_old_introduction
      end      
      it '更新後のリダイレクト先は自分のユーザー詳細画面である' do
        expect(current_path).to eq member_path(member)
      end
    end  
  end

end