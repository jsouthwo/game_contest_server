class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true

  has_many :players, through: :player_matches
  has_many :player_matches

  validates :manager, presence: true

  validates :completion, presence: true
#  validates :earliest_start, presence: true
end
