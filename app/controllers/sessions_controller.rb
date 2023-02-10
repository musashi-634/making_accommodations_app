class SessionsController < ApplicationController
  before_action :require_login, only: :destroy

  def new; end

  def create
    @user = User.find_by(email: session_params[:email].downcase)
    if @user&.authenticate(session_params[:password])
      log_in(@user)
      redirect_to root_path
    else
      @user = User.new(session_params) # render時に値を保持するため
      flash.now[:alert] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
