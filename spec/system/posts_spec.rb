require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:member) { create(:member) }
  let(:other_member) { create(:member) }
  let!(:post) { create(:post, movie:'hoge',title:'hoge',details:'hoge', member_id: member.id) }


  describe '新規投稿のテスト' do
    before do
      sign_in member
      visit new_post_path
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[movie]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[details]', with: Faker::Lorem.characters(number:20)
        click_button 'Create Post'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      sign_in member
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.movie
        expect(page).to have_link post.movie
      end
    end
  end
  
  describe '詳細画面のテスト' do
    before do
      sign_in member
      visit edit_post_path 
    end
  end  


end