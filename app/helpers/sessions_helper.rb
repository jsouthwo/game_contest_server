module SessionsHelper

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
        @user = User.find(params[:id])
        unless current_user?(@user)
            flash[:danger] = "#{current_user.username}, you may not update that account."
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


