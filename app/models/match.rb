class Match < ActiveRecord::Base
    belongs_to :manager, polymorphic: true

    has_many :players, through: :player_matches
    has_many :player_matches

    validates :manager,         presence: true
    validates :status,          presence: true
    validates :earliest_start,  presence: true, allow_blank: true
    validates :earliest_start,  timeliness: { type: :date, on_or_after: :now }, if: :waiting?
    validates :completion,      presence: true
    validates :completion,      timeliness: { type: :date, on_or_before: :now }, if: :completed?

    validate :correct_number_of_players

    def correct_number_of_players
        if manager
            errors.add('players.count', "must equal " + manager.referee.players_per_game.to_s) unless players.count == manager.referee.players_per_game
        end
    end

    def completed?
        self.status.downcase == "completed"
    end

    def waiting?
        self.status.downcase == "waiting"
    end

end
