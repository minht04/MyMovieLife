require 'rails_helper'

RSpec.describe 'Member::Relationshipsリクエストのテスト', type: :request do
  let(:follower) { create(:member) }
  let(:followed) { create(:member) }

  describe 'フォローする機能(POST #create)' do
    context 'ログインしている場合' do
      before do
        sign_in follower
      end

      it '非同期によるフォローが成功すること' do
        post member_relationships_path(followed.id), xhr: true
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'フォローを外す機能(DELETE #destroy)' do
    let!(:follow) { Relationship.create(follower_id: follower.id, followed_id: followed.id) }

    context 'ログインしている場合' do
      before do
        sign_in follower
      end

      it '非同期によるアンフォローが成功すること' do
        delete member_relationships_path(followed.id), xhr: true
        expect(response).to have_http_status '200'
      end
    end
  end
end
