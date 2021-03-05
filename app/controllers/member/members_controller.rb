class Member::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update, :edit]


  def index
    @member = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order
  end

  def edit
  end

  def update
  end

  def correct_member
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to member_path(current_member.id)
    end
  end

end
