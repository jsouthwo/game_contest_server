class UsersController < ApplicationController
    before_action :ensure_user_not_logged_in__flash_warn_goes_to_root, only: [:new, :create]

    before_action only: [:edit, :update] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_correct_user__flash_danger_goes_to_root
        end
    end

    
    before_action :ensure_admin__flash_danger_goes_to_root, only: [:destroy]


    respond_to :html, :json, :xml


    def new
        @user = User.new
        respond_with(@user)
    end

=begin  For documentation purposes
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
=end

    def create
        @user = User.new(acceptable_params)

        if @user.save
            flash[:success] = "Welcome to the site, #{@user.username}."
            login(@user)
        end
        respond_with(@user)
    end

    def edit
        @user = User.find(params[:id])
        respond_with(@user)
    end


    def update
        @user = User.find(params[:id])
        if @user.update(acceptable_params)
            flash[:success] = "Successfully updated your account, #{@user.username}."
        end
        respond_with(@user)
    end


    def show
        @user = User.find(params[:id])
    end


    def index
        @users = User.all
        respond_with(@users)
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

=begin
    def destroy
        @user = User.find(params[:id])
        # TODO: Move this into a before action to allow the danger flash to work.
        if current_user?(@user) then # Don't let admin delete self
            flash[:danger] = "Admin may not delete self."
            redirect_to root_path
        else
            flash[:success] = "#{@user.username} deleted"
            @user.destroy
        end
        respond_with(@user)
    end
=end


    private
        def acceptable_params
            params.require(:user).permit(:username, :password, :password_confirmation, :email)
        end
end
