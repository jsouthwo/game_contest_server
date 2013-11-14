module UsersHelper

    def contest_creator?(user)
        logged_in? and user.contest_creator
    end


    def ensure_contest_creator
        @user = current_user
        unless current_user?(@user) and contest_creator?(@user)
            flash[:danger] = "#{current_user.username}, you may not do that."
            redirect_to root_path
        end
    end

=begin
    def ensure_contest_owner
        @user = User.find(params[:id])
        unless current_user?(@user) and contest_creator?(@user)
            flash[:danger] = "#{current_user.username}, you may not do that."
            redirect to root_path
        end
    end
=end

end
