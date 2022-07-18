class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user
  attr_accessor :name, :email

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to edit_user_path current_user
    else
      flash[:danger] = t ".update_faild"
      redirect_to edit_user_path current_user
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy; end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit User::UPDATABLE_ATTRS
  end
  def correct_user
    return if current_user? @user

    flash[:danger] = t "flash.login_plz"
    redirect_to root_path
  end
end
