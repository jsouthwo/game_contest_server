require 'securerandom'
class Referee < ActiveRecord::Base
    
    def referee
        self
    end

    belongs_to :user

    has_many :contests
    has_many :matches, as: :manager

    include Uploadable

    validates :name,                presence: true, uniqueness: true
    validates :rules_url,           presence: true, url: true
# OR format: {with: URI::regexp}
    validates :players_per_game,    presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 } 

end
