class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      log_in(@user)
      flash[:notice] = 'ユーザを新規登録しました'
      redirect_to user_account_path
    else
      flash.now[:alert] = 'ユーザを新規登録できませんでした'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    current_user.assign_attributes(
      params.require(:user).permit(:email, :password, :password_confirmation, :password_current)
    )
    if current_user.save(context: :account_update)
      flash[:notice] = 'アカウントを更新しました'
      redirect_to user_account_path
    else
      flash.now[:alert] = 'アカウントを更新できませんでした'
      render 'edit'
    end
  end
end
