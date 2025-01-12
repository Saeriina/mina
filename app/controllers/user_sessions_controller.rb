class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    Rails.logger.debug("Creating user: #{@user.inspect}")
    if @user
      redirect_to root_path, success: "ログインしました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: "ログアウトしました"
  end
end
