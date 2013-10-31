class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true

  has_many :players, through: :player_matches

  validates :manager, presence: true
end
