require 'rails_helper'

RSpec.describe 'Memberモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { member.valid? }

    let!(:other_member) { create(:member) }
    let(:member) { build(:member) }

    context 'nameカラム' do
      it '空欄でないこと' do
        member.name = ''
        is_expected.to eq false
      end
      it '20文字以下であること：20文字は○' do
        member.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること：21文字は×' do
        member.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        member.name = other_member.name
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること：50文字は○' do
        member.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること：51文字は×' do
        member.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデル(Favorite)との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Favoriteモデル(Favorite_post)との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:favorite_posts).macro).to eq :has_many
      end
    end

    context 'Relationshipモデル(フォローしている人(follower))との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:follower).macro).to eq :has_many
      end
      it 'Relationshipモデルにより結合されている' do
        expect(Member.reflect_on_association(:follower).class_name).to eq 'Relationship'
      end
    end

    context 'Relationshipモデル(フォローされている人(followed))との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:followed).macro).to eq :has_many
      end
      it 'Relationshipモデルにより結合されている' do
        expect(Member.reflect_on_association(:followed).class_name).to eq 'Relationship'
      end
    end

    context '自分がフォローしている人(following_member)との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:following_member).macro).to eq :has_many
      end
    end

    context '自分がフォローしている人(follower_member)との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:follower_member).macro).to eq :has_many
      end
    end

    context 'Notificationモデル(active_notifications(自分から相手への通知))との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it 'Notificationモデルにより結合されている' do
        expect(Member.reflect_on_association(:active_notifications).class_name).to eq 'Notification'
      end
    end

    context 'Notificationモデル(passive_notifications(相手から自分への通知))との関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
      it 'Notificationモデルにより結合されている' do
        expect(Member.reflect_on_association(:passive_notifications).class_name).to eq 'Notification'
      end
    end

    context 'SnsCredentialモデルとの関係' do
      it '1:Nの関係になっている' do
        expect(Member.reflect_on_association(:sns_credentials).macro).to eq :has_many
      end
    end
  end
end
