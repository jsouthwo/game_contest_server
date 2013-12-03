class Match < ActiveRecord::Base
    belongs_to :manager, polymorphic: true

    has_many :players, through: :player_matches
    has_many :player_matches

    validates :manager, presence: true

    #  validates :earliest_start, presence: true
    validates :status, presence: true
    validates :completion, presence: true
# TODO: HELP!!
## Shouldn't match have a referee or ref_id???
=begin NOT SURE HOW TO DO THIS
    validates :players, presence: true, numericality: { only_integer: true, equal_to: :referee. }
    puts :status
    if :status.to_s == "Completed"
        validates :completion, timeliness: { on_or_before: :now }
    end
=end

end
