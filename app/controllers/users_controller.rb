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
            flash[:success] = "Welcome to the site: #{@user.username}"
            render template: 'sessions#create'
            redirect_to @user
        else
            render :new
        end
    end


    def edit
        @user = User.find(params[:id])
        if ! ( ensure_admin?(@user) or ensure_correct_user(@user) )
            render login_path
        end
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
            redirect_to user_path
        else
            render :edit
        end
    end


    def destroy
        @user = User.find(params[:id])
        if current_user?(@user) then # Don't let admin delete self
            flash[:danger] = "Admin may not delete self."
            redirect_to root_path
        else
            @user.destroy
            redirect_to root_path
        end
    end



    private
        def acceptable_params
            params.require(:user).permit(:username, :password, :password_confirmation, :email)
        end

        def ensure_user_not_logged_in
            if logged_in?
                flash[:warning] = "Cannot be logged in"
                redirect_to root_path
            end
        end

        def ensure_user_logged_in
            unless logged_in?
                flash[:warning] = "Gotta be logged in"
                redirect_to login_path
            end
        end


        def ensure_correct_user
            unless current_user?(@user)
                flash[:danger] = "#{current_user}, you may not update #{@user}'s account."
                redirect_to root_path
            end
        end

        def ensure_admin
            unless current_user.admin?
                flash[:warning] = "Gotta be an admin"
                redirect_to root_path
            end
        end

end
