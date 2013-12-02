class Match < ActiveRecord::Base
    belongs_to :manager, polymorphic: true

    has_many :players, through: :player_matches
    has_many :player_matches

    validates :manager, presence: true

    #  validates :earliest_start, presence: true
    validates :status, presence: true
    validates :completion, presence: true
=begin NOT SURE HOW TO DO THIS
    puts :status
    if :status.to_s == "Completed"
        validates :completion, timeliness: { on_or_before: :now }
    end
=end

end
