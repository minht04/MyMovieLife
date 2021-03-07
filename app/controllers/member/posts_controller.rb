class Member::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :correct_post,only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:tag_name].split(nil)
    @post.save
    @post.save_tag(tag_list)
    redirect_to post_path(@post)
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @tag_list = Tag.joins(:posts)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
    @post_tags = @post.tags
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

  def search
    @tag_list = Tag.joins(:posts)
    @tag = Tag.find(params[:tag_id]) #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグの投稿を全て表示
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
