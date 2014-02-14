class UsersController < ApplicationController
  before_filter { |c| c.authenticate_role(:admin) }
  before_filter :get_user, only: [:update, :show, :edit, :destory]

  def index
    @users = User.all 
    respond_with @users
  end

  def update
    if @user.update_attributes params[:user]
      Role.add_role(@user, params[:role])
      respond_with @user, location: "/users"
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to '/users'
    end
  end

  def show
    respond_with @user
  end

  def edit
    respond_with @user
  end

  def destroy
    @user.destroy
    respond_with @user, location: root_path
  end

  private
    def get_user
      @user = User.find(params[:id])
    end
end
