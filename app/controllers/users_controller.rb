class UsersController < ApplicationController
    before_action only: [:new, :create] do
        ensure_user_not_logged_in
    end

    before_action only: [:edit, :update] do
        ensure_user_logged_in
    end

    before_action only: [:edit, :update] do
        ensure_correct_user
    end

    before_action only: [:destroy] do
        ensure_admin
    end

    def new
        @user = User.new
    end


    def create
        @user = User.new(acceptable_params)

        if @user.save
            flash[:success] = "Welcome to the site, #{@user.username}."
            login(@user)
            redirect_to @user
        else
            render :new
        end
    end


    def edit
        @user = User.find(params[:id])
    end


    def update
        @user = User.find(params[:id])
        if @user.update(acceptable_params)
            flash[:success] = "Successfully updated your account, #{@user.username}."
            redirect_to user_path
        else
            render :edit
        end
    end


    def show
        @user = User.find(params[:id])
    end


    def index
        @users = User.all
    end


    def destroy
        @user = User.find(params[:id])
        if current_user?(@user) then # Don't let admin delete self
            flash[:danger] = "Admin may not delete self."
            redirect_to root_path
        else
            flash[:success] = "#{@user.username} deleted"
            @user.destroy
            redirect_to users_path
        end
    end



    private
        def acceptable_params
            params.require(:user).permit(:username, :password, :password_confirmation, :email)
        end
end
