class PostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :non_authors_cant_edit_post, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
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
    @comments_by_parent_id = @post.comments_by_parent_id
    @all_comments = @post.comments
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:notice] = ["Post successfully updated!"]
      redirect_to post_url(@post)
    else
      flash[:failure] = @post.errors.full_messages
      render :edit
    end
  end

  def upvote
    vote = Vote.new(user_id: current_user.id)
    post = Post.find(params[:id])
    vote.votable = post
    vote.save

    redirect_to sub_url(params[:sub][:id])
  end

  def downvote
    vote = Vote.new(user_id: current_user.id, upvote: false)
    post = Post.find(params[:id])
    vote.votable = post
    vote.save

    redirect_to sub_url(params[:sub][:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def ensure_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def non_authors_cant_edit_post
    unless current_user == Post.find(params[:id]).author
      redirect_to post_url(params[:id])
    end
  end

end
