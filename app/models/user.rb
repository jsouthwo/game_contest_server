class User < ActiveRecord::Base
    has_secure_password

    validates :username,       presence: true, uniqueness: true, length: {maximum: 20}
    validates :password,       presence: true
#    validates :password_confirmation,   presence: true
    validates :email,          presence: true, format: /(\w+)@([a-zA-Z]+)(\.)([a-zA-Z])/i
end
