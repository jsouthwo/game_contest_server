module SessionsHelper
    # TODO: need to unsign cookies?

    def logged_in?
        !current_user.nil?
    end

    def current_user
        # or-equals (Find if you'ven't already
        # Like +=
        # bool || bool = expression shortcircuits if bool is true
        @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
    end

    def current_user?(user)
        current_user == user
    end

    def login(user)
        cookies.signed[:user_id] = user.id
    end

end


