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
    binding.pry
    if @user.save
      redirect_to admin_users_path, notice: "User created, #{@user.firstname}!"
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
    @user = User.find(params[:id])

    UserMailer.delete_email(@user).deliver_later
    @user.destroy

    redirect_to admin_users_path, notice: "deleted"
  end

  protected
    def user_params
      params.require(:user).permit(
        :email, :firstname, :lastname, :password, :password_confirmation
      )
    end
end
