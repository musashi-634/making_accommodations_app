class Users::ProfilesController < ApplicationController
  before_action :require_login, only: %i[show edit]

  def show; end

  def edit; end

  def update
    if current_user.update(params.require(:user).permit(:avatar, :name, :introduction))
      current_user.avatar.purge if params[:user][:avatar_request_delete]
      flash[:notice] = 'プロフィールを更新しました'
      redirect_to user_profile_path
    else
      current_user.avatar = nil if current_user.errors[:avatar]
      flash.now[:alert] = 'プロフィールを更新できませんでした'
      render 'edit'
    end
  end
end
