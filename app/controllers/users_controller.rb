class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      flash[:notice] = 'ユーザを新規登録しました'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'ユーザを新規登録できませんでした'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(
      params.require(:user).permit(:email, :password, :password_confirmation, :password_current)
    )
    if @user.save(context: :account_update)
      flash[:notice] = 'アカウントを更新しました'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'アカウントを更新できませんでした'
      render 'edit'
    end
  end
end
