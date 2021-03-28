require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Memberモデル(follower)との関係' do
      it 'N:1の関係になっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end

      it 'Memberモデルにより結合されている' do
        expect(Relationship.reflect_on_association(:follower).class_name).to eq 'Member'
      end
    end

    context 'Memberモデル(followed)との関係' do
      it 'N:1の関係になっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end

      it 'Memberモデルにより結合されている' do
        expect(Relationship.reflect_on_association(:followed).class_name).to eq 'Member'
      end
    end
  end
end