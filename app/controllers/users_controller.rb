class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        # TODO ASSIGNMENT IS TO TRY TO FIGURE OUT WHY THIS DOESN'T WORK!!!
        #@user = User.new(params[:user])
        #@user = User.new(do something..), we'd want it to look like ^, but that shouldn't work.

=begin
        @user.save
=end
    end
end
