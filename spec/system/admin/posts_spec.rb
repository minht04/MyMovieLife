require 'rails_helper'

RSpec.describe 'Admin::Postsコントローラーのテスト', type: :system do
  let!(:admin) { create(:admin) }
  let!(:member) { create(:member) }
  let(:other_member) { create(:member) }
  let!(:post) { create(:post, member_id: member.id) }
  let!(:comment) { create(:comment, post_id: post.id, member_id: other_member.id) }

  before do
    sign_in admin
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit admin_posts_path
    end

    context '表示の確認' do
      it 'movieが表示されているか' do
        expect(page).to have_content post.movie
      end
      it 'titileが表示されているか' do
        expect(page).to have_content post.title
      end
      it '投稿詳細画面のリンクが表示されているか' do
        expect(page).to have_link '', href: admin_post_path(post)
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit admin_post_path(post)
    end

    context '表示の確認' do
      it '投稿者の名前が表示されているか' do
        expect(page).to have_content post.member.name
      end
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
      it '投稿削除のリンクが表示されているか' do
        expect(page).to have_link '', href: admin_post_path(post)
      end
      it 'コメント削除のリンクが表示されているか' do
        expect(page).to have_link '', href: admin_post_comment_path(comment.post_id, comment.id)
      end
    end
    context '削除処理のテスト' do
      it '投稿が正しく削除される' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
      it 'コメントが正しく削除される' do
        expect{ comment.destroy }.to change{ Comment.count }.by(-1)
      end
    end
  end

end