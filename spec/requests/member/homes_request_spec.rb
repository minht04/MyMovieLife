require 'rails_helper'

RSpec.describe 'Homesリクエストのテスト', type: :request do
  describe 'トップページ(ルート)' do
    context 'ページが正しく表示される' do
      before do
        get root_path
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'アバウトページ' do
    context 'ページが正しく表示される' do
      before do
        get home_about_path
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq(200)
      end
    end
  end
end
