class Users::ProfilesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update(params.require(:user).permit(:name, :icon, :introduction))
      flash[:notice] = 'プロフィールを更新しました'
      redirect_to user_profile_path(@user)
    else
      flash.now[:alert] = 'プロフィールを更新できませんでした'
      render 'edit'
    end
  end
end
