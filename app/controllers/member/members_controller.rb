class Member::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update, :edit]
  before_action :check_guest, only: [:update]


  def index
    @members = Member.page(params[:page]).reverse_order
  end

  def show
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
  
  def follower # follower一覧
    member = Member.find(params[:id])
    @members = member.following_member
  end  
  
  def followed # followed一覧
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
