class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = ["Welcome!"]
      redirect_to user_url(@user)
    else
      flash[:failure] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    rendow :show
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = ["Successfully updated profile!"]
      redirect_to user_url(@user)
    else
      flash[:failure] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])

    user.destroy

    redirect_to new_user_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
