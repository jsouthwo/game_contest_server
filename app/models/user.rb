class User < ActiveRecord::Base
    has_secure_password

    has_many :referees
    has_many :contests
    has_many :players
    has_many :matches, as: :manager

    validates :username,       presence: true, uniqueness: true, length: {maximum: 20}
    validates :password,       presence: true
    validates :email,          presence: true, format: /(\w+)@([a-zA-Z]+)(\.)([a-zA-Z])/i
end
