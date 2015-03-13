class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "wrong credentials"
      render :new
    end
  end

  def new
    @user = User.new

    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
