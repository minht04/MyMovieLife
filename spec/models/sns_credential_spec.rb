require 'rails_helper'

RSpec.describe 'SnsCredentialモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Memberモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(SnsCredential.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end
  end
end
