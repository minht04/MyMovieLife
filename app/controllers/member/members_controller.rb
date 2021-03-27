class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: %i[update edit]
  before_action :check_guest, only: [:update]

  def index
    @members = Member.page(params[:page]).reverse_order.per(8)
    # 検索
    unless params[:content].nil?
      @content = params[:content]
      @members = Member.where("name like '%" + params[:content] + "%'").where(is_deleted: false).page(params[:page]).reverse_order
    end
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order
    @favorite_posts = @member.favorite_posts.page(params[:page]).reverse_order # お気に入り一覧
  end

  def favorites
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end

  # follower一覧
  def follows
    @member = Member.find(params[:id])
    @members = @member.following_member.page(params[:page]).reverse_order
  end

  # followed一覧
  def followers
    @member = Member.find(params[:id])
    @members = @member.follower_member.page(params[:page]).reverse_order
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    redirect_to member_path(current_member.id) unless @member.id == current_member.id
  end

  def check_guest
    @member = Member.find(params[:id])
    redirect_to members_path, alert: 'ゲストユーザーは編集できません。' if @member.name == 'ゲスト'
  end

  def timeline
    @member = current_member
    @members = @member.following_member
    follows_ids = @member.following_member.pluck(:id)  # フォローしている人のIDだけを取り出す
    follows_ids.push(@member.id)                       # フォローしている人のID配列に自分のIDも追加
    @posts = Post.where(member_id: follows_ids).page(params[:page]).reverse_order
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :introduction, :is_deleted)
  end
end
