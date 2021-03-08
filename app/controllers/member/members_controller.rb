class Member::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update, :edit]
  before_action :check_guest, only: [:update]


  def index
    @members = Member.page(params[:page]).reverse_order
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order
    @favorite_posts = @member.favorite_posts    #お気に入り一覧で追加
  end
  
  def favorites
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order
    @favorite_posts = @member.favorite_posts    #お気に入り一覧で追加
  end    

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end

  def follows # follower一覧
    member = Member.find(params[:id])
    @members = member.following_member
  end

  def followers # followed一覧
    member = Member.find(params[:id])
    @members = member.follower_member
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to member_path(current_member.id)
    end
  end

  def check_guest
    @member = Member.find(params[:id])
    if @member.name == 'ゲスト'
      redirect_to members_path, alert: 'ゲストユーザーは編集できません。'
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :introduction)
  end

end
