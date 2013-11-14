class Player < ActiveRecord::Base
    belongs_to :user
    belongs_to :contest

    has_many :matches, through: :player_matches
    has_many :player_matches

=begin
#    validates :file_location, presence: true
    validates :description,     presence: true
    validates :name,            presence: true
    validates :downloadable,    presence: true
    validates :playable,        presence: true
=end
    validates :contest,         presence: true 
    validates :user,            presence: true 
end
