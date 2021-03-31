require 'rails_helper'

RSpec.describe 'TagMapモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Tagモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(TagMap.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(TagMap.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
