module SessionsHelper
    
    ## General functions
    def logged_in?
        !current_user.nil?
    end

    def current_user
        @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
    end

    def current_user?(user)
        current_user == user
    end

    def login(user)
        cookies.signed[:user_id] = user.id
    end


    ## Ensuring functions
    def ensure_user_not_logged_in__flash_warn_goes_to_root
        if logged_in?
            flash[:warning] = "Cannot be logged in"
            redirect_to root_path
        end
    end

    def ensure_user_logged_in__flash_warn_goes_to_login
        unless logged_in?
            flash[:warning] = "Gotta be logged in"
            redirect_to login_path
        end
    end

    def ensure_correct_user__flash_danger_goes_to_root
        @user = User.find(params[:id])
        unless current_user?(@user)
            flash[:danger] = "#{current_user.username}, you may not update that account."
            redirect_to root_path
        end
    end

    def ensure_admin__flash_warn_goes_to_root
        unless current_user.admin?
            flash[:warning] = "Gotta be an admin"
            redirect_to root_path
        end
    end

    def ensure_admin__flash_danger_goes_to_root
        unless current_user.admin?
            flash[:danger] = "Gotta be an admin"
            redirect_to root_path
        end
    end

    def ensure_user_owns_referee__flash_danger_goes_to_root
#        @user = User.find(params[:id])
        @referee = Referee.find(params[:id])
        @user = @referee.user
        unless current_user?(@user)
            #flash[:danger] = "#{current_user.username}, you may not change that referee."
            flash[:danger] = "You may not do that."
            redirect_to root_path
        end
    end
    
    def ensure_user_owns_contest__flash_danger_goes_to_root
        @contest = Contest.find(params[:id])
        @user = @contest.user
        unless current_user?(@user)
            #flash[:danger] = "#{current_user.username}, you may not change that contest."
            flash[:danger] = "You may not do that."
            redirect_to root_path
        end
    end
end


