class Member::CommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.member_id = current_member.id
    @comment.save
    @post.create_notification_comment!(current_member, @comment.id)
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :member_id)
  end
end
