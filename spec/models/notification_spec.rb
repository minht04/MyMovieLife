require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Memberモデル(visitor)との関係' do
      it 'N:1の関係になっている' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end

      it 'Memberモデルにより結合されている' do
        expect(Notification.reflect_on_association(:visitor).class_name).to eq 'Member'
      end
    end

    context 'Memberモデル(visited)との関係' do
      it 'N:1の関係になっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end

      it 'Memberモデルにより結合されている' do
        expect(Notification.reflect_on_association(:visited).class_name).to eq 'Member'
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end
  end

end