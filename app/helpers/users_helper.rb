module UsersHelper

    def contest_creator?(user)
        logged_in? and user.contest_creator
    end

end
