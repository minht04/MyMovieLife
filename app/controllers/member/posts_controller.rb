class Member::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :correct_post,only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:tag_name].split(',')
    @post.save
    @post.save_tag(tag_list)
    redirect_to post_path(@post)
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @tag_list = Tag.joins(:posts).group(:id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    @post.update(post_params)
    @post.save_tag(tag_list)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search       #タグごとに投稿一覧表示
    @tag_list = Tag.joins(:posts).group(:id)
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
