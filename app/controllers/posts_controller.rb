class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id

    if @post.save
      redirect_to sub_post_url(sub_id: @post.sub_id, id: @post.id)
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
      redirect_to sub_post_url(sub_id: @post.sub_id, post_id: @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    sub_id = post.sub_id

    post.destroy
    redirect_to sub_url(sub_id)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def is_author?
    post = Post.find(params[:id])
    
    unless current_user.id == post.author_id
      redirect_to sub_post_url(sub_id: post.sub_id, id: post.id)
    end
  end
end
