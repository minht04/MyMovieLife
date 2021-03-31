require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { comment.valid? }

    let(:member) { create(:member) }
    let(:post) { create(:post) }
    let!(:comment) { build(:comment, member_id: member.id, post_id: post.id) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        comment.body = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Memberモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Comment.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
