require 'rails_helper'

RSpec.describe 'Postsコントローラーのテスト', type: :system do
  let(:member) { create(:member) }
  let(:other_member) { create(:member) }
  let!(:post) { create(:post, movie:'hoge',title:'hoge',details:'hoge', member_id: member.id) }

  describe '新規投稿のテスト' do
    before do
      sign_in member
      visit new_post_path
      fill_in 'post[movie]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[details]', with: Faker::Lorem.characters(number:20)
    end
    context '投稿処理のテスト' do
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button 'Create Post' }.to change(member.posts, :count).by(1)
      end
      it '投稿後のリダイレクト先は正しいか' do
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
      visit post_path(post)
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.movie
        expect(page).to have_content post.title
        expect(page).to have_content post.details
      end
    end
    context '投稿削除処理のテスト' do
      it '投稿が正しく削除される' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      sign_in member
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it '編集前の映画名を詳細がフォームに表示されている' do
        expect(page).to have_field 'post[movie]',with:post.movie
        expect(page).to have_field 'post[title]',with:post.title
        expect(page).to have_field 'post[details]',with:post.details
      end
      it '保存ボタンが表示されている' do
        expect(page).to have_button 'Update Post'
      end
    end
    context '更新処理のテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[movie]',with:Faker::Lorem.characters(number:10)
        fill_in 'post[title]',with:Faker::Lorem.characters(number:10)
        fill_in 'post[details]',with:Faker::Lorem.characters(number:20)
        click_button 'Update Post'
        expect(page).to have_current_path post_path(post)
      end
    end
  end

end