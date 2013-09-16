class UsersController < ApplicationController
    def new
        @user = Users.new
    end
end
