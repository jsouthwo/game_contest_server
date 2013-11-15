module UsersHelper

    def contest_creator?(user)
        logged_in? and user.contest_creator
    end


    def ensure_contest_creator__flash_danger_goes_to_root
        unless contest_creator?(current_user)
            flash[:danger] = "#{current_user.username}, you may not view that info do that."
            redirect_to root_path
        end
    end

end
