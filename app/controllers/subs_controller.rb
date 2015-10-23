class SubsController < ApplicationController

  before_action :ensure_logged_in
  before_action :non_mods_cant_edit_subs, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

    if @sub.save
      flash[:notice] = ["Welcome #{@sub.title}!"]
      redirect_to sub_url(@sub)
    else
      flash[:failure] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])

    render :show
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update_attributes(sub_params)
      flash[:notice] = ["Sub successfully updated!"]
      redirect_to sub_url(@sub)
    else
      flash[:failure] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def ensure_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def non_mods_cant_edit_subs
    unless current_user == Sub.find(params[:id]).moderator
      redirect_to sub_url(params[:id])
    end
  end

end
