class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    if signed_in?
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    if signed_in?
      redirect_to root_path
    end
    @user = User.new(user_params)
    if @user.save
      sign_in @user    # save remember_token to sessoin(cookie/instant var.) and user
      flash[:success] = "Welcome to the Sample App! いらっしゃいませー"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
    # if @user.update_attributes(params[:user])  # 演習 9.6.1 の赤色のために
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = "Admin user may not delete yourself."
      redirect_to root_path
    else
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   # :admin, # 演習 9.6.1 の赤色のために
                                   :password_confirmation )
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
