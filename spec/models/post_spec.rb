require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it '有効な投稿内容の場合に保存されるか' do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:member) { create(:member) }
    let!(:post) { build(:post, member_id: member.id) }

    context 'movieカラム' do
      it '空欄でないこと' do
        post.movie = ''
        is_expected.to eq false
      end
    end

    context 'detailsカラム' do
      it '空欄でないこと' do
        post.details = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Memberモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Post.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'TagMapモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Post.reflect_on_association(:tag_maps).macro).to eq :has_many
      end
    end

    context 'Tagモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Post.reflect_on_association(:tags).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end