class UsersController < ApplicationController
    before_action :ensure_user_logged_in, only: [:edit, :update]
    before_action :ensure_correct_user, only: [:edit, :update]
    before_action :ensure_admin, only: [:destroy]

    def new
        @user = User.new
    end


    def create
        @user = User.new(acceptable_params)

        if @user.save
            flash[:success] = "Welcome to the site: #{@user.username}"
            render template: 'sessions#create'
            #redirect_to @user
        else
            render :new
        end
    end


    def edit
        @user = User.find(params[:id])
    end


    def show
        @user = User.find(params[:id])
    end


    def index
        @users = User.all
    end


    def update
        @user = User.find(params[:id])
        if @user.update(acceptable_params)
            flash[:success] = "Successfully updated your account, #{@user.username}."
            redirect_to root_path
        else
            render :edit
        end
    end


    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end



    private
        def acceptable_params
            params.require(:user).permit(:username, :password, :password_confirmation, :email)
        end


        def ensure_user_logged_in
            redirect_to login_path unless logged_in?
        end


        def ensure_correct_user
            redirect_to users_path unless current_user?(@user)
        end

        def ensure_admin
            redirect_to root_path unless current_user.admin?
        end

end
