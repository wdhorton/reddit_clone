class PostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :non_authors_cant_edit_post, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      flash[:notice] = ["Post created successfully!"]
      redirect_to post_url(@post)
    else
      flash[:failure] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end

  def edit
    @post = Post.find(params[:id])

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:notice] = ["Post successfully updated!"]
      redirect_to sub_url(@post)
    else
      flash[:failure] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def ensure_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def non_mods_cant_edit_subs
    unless current_user == Post.find(params[:id]).author
      redirect_to post_url(params[:id])
    end
  end


end
