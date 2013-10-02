class UsersController < ApplicationController
    def new
        @user = User.new
    end


    def acceptable_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end


    def create
        @user = User.new(acceptable_params)

        if @user.save
            redirect_to @user
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
            redirect_to @user
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end

end
