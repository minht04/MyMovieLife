class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

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
    redirect_to admin_member_path(@member.id)
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :introduction, :is_deleted)
  end
end
