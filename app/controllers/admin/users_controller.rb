class Admin::UsersController < ApplicationController

  before_filter :admin_access

  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "updated"
    else
      render :show, notice: "error"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: "deleted"
  end

  protected
    def user_params
      params.require(:user).permit(
        :email, :firstname, :lastname, :role
      )
    end
end
