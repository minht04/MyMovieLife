class Member::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])
    @member.create_notification_follow!(current_member)
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(params[:member_id])
  end
end
