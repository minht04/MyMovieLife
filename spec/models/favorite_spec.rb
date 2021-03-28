require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Memberモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Favorite.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end

end