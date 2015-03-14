class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])

    post.destroy
    redirect_to subs_url
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params[:post][:sub_ids] ||= []
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def is_author?
    post = Post.find(params[:id])

    unless current_user.id == post.author_id
      redirect_to post_url(post)
    end
  end
end
