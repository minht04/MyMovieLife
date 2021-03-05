class Member::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :correct_post,only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    redirect_to post_path(@post)
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def correct_post
    @post = Post.find(params[:id])
    unless @post.member.id == current_member.id
      redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:movie, :title, :body, :image)
  end


end
