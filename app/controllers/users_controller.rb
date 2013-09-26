class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        acceptable_params = params.require(:user).permit(:username, :password, :password_confirmation, :email)
        @user = User.new(acceptable_params)

        if @user.save
            redirect_to @user
        else
            render :new
        end
    end

end
