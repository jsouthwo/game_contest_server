module UsersHelper

    def contest_creator?(user)
        logged_in? and user.contest_creator
    end


    def ensure_contest_creator
        @user = User.find(params[:id])
        unless current_user?(@user) and contest_creator?(@user)
            flash[:danger] = "#{current_user.username}, you may not do that."
            redirect to login_path
        end
    end

end
