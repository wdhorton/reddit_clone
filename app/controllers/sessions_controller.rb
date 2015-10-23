class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    return nil unless user

    log_in!(user)

    redirect_to user_url(user)
  end

  def destroy
    log_out!

    redirect_to new_session_url
  end

end
