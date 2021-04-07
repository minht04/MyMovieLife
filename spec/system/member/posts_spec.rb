require 'rails_helper'

RSpec.describe 'Member::Postsコントローラーのテスト', type: :system do
  let(:member) { create(:member) }
  let(:other_member) { create(:member) }
  let!(:post) { create(:post, movie:'hoge',title:'hoge',details:'hoge', member_id: member.id) }
  let!(:comment) { create(:comment, post_id: post.id, member_id: other_member.id) }

  before do
    sign_in member
  end

  describe '新規投稿のテスト' do
    before do
      visit new_post_path
      fill_in 'post[movie]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[details]', with: Faker::Lorem.characters(number:20)
    end
    context '投稿処理のテスト' do
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button 'Create Post' }.to change(member.posts, :count).by(1)
      end
      it '投稿後のリダイレクト先はその投稿詳細画面である' do
        click_button 'Create Post'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe "投稿一覧画面のテスト" do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.movie
      end
      it '投稿詳細画面のリンクが存在するか' do
        expect(page).to have_link post.movie, href: post_path(post)
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end
    context '表示の確認' do
      it '投稿されたmovieが表示されているか' do
        expect(page).to have_content post.movie
      end
      it '投稿されたtitleが表示されているか' do
        expect(page).to have_content post.title
      end
      it '投稿されたdetailsが表示されているか' do
        expect(page).to have_content post.details
      end
      it 'コメントが表示されているか' do
        expect(page).to have_content comment.body
      end
      it 'コメントした人の名前が表示されているか' do
        expect(page).to have_content comment.member.name
      end
    end
    context '投稿削除処理のテスト' do
      it '投稿が正しく削除される' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it 'Imageフォームが表示されている' do
        expect(page).to have_field 'post[image]'
      end
      it '編集前の映画名がフォームに表示されている' do
        expect(page).to have_field 'post[movie]',with:post.movie
        expect(page).to have_field 'post[details]',with:post.details
      end
      it 'Wordフォームが表示されている' do
        expect(page).to have_field 'post[title]'
      end
      it '編集前の詳細がフォームに表示されている' do
        expect(page).to have_field 'post[details]',with:post.details
      end
      it '保存ボタンが表示されている' do
        expect(page).to have_button 'Update Post'
      end
    end

    context '投稿更新処理のテスト' do
      before do
        @post_old_movie = post.movie
        @post_old_title = post.title
        @post_old_details = post.details
        fill_in 'post[movie]',with:Faker::Lorem.characters(number:10)
        fill_in 'post[title]',with:Faker::Lorem.characters(number:10)
        fill_in 'post[details]',with:Faker::Lorem.characters(number:20)
        click_button 'Update Post'
      end

      it '更新後のリダイレクト先はその投稿詳細画面である' do
        expect(page).to have_current_path post_path(post)
      end
      it 'movieが正しく更新されている' do
        expect(post.reload.movie).not_to eq @post_old_movie
      end
      it 'titleが正しく更新されている' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it 'detailsが正しく更新されている' do
        expect(post.reload.details).not_to eq @post_old_details
      end
    end
  end

end