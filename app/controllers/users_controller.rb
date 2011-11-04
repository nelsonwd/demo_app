class UsersController < ApplicationController
before_filter :authenticate, :only => [:index, :edit, :update]
before_filter :correct_user, :only => [:edit, :update]
before_filter :admin_user, :only => [:destroy]
  def index
    @title = "All users"
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @title = "Profile"
  end

  def new
    @title = "Sign up"
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @title = "Edit User"
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      #sign_in @user
      flash[:success] = "Welcome to the sybiodinium project! Your account will need to be activated by a project adminstrator."
      redirect_to signin_path
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end

  def admin_user
    deny_access unless current_user.admin?
  end

end
