require 'securerandom'
class Player < ActiveRecord::Base
    belongs_to :user
    belongs_to :contest

    has_many :matches, through: :player_matches
    has_many :player_matches

    include Uploadable

    validates :description,     presence: true
    validates :name,            presence: true, uniqueness: {scope: :contest_id}
    validates :contest,         presence: true 
    validates :user,            presence: true 

end
